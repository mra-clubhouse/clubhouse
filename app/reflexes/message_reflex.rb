# frozen_string_literal: true

class MessageReflex < ApplicationReflex
  def send
    return if no_message?

    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      broadcast_new_message
    end

    update_typing_feedback("")

    morph :nothing
  end

  def typing
    update_typing_feedback

    morph :nothing
  end

  def load_more(options)
    using_regional_replica do
      @messages = Message.includes(:user).where("created_at < ?", Time.at(options[:timestamp].to_i)).
        order(:created_at).reverse_order.limit(options[:limit].to_i).load
    end

    broadcast_load_more(options)

    morph :nothing
  end

  private

  def broadcast_load_more(options)
    if @messages.any?
      cable_ready["messages"].append(
        selector: "#messages",
        html: render(partial: "messages/message", collection: @messages, as: :message)
      ).scroll_into_view(
        selector: "##{options[:last_id]}",
        block: "nearest"
      ).broadcast
    else
      cable_ready["messages"].remove(selector: "#intersector").broadcast
    end
  end

  def broadcast_new_message
    cable_ready["messages"].
      insert_adjacent_html(
        selector: "#messages",
        position: "afterbegin",
        html: render(partial: "messages/message", locals: { message: @message })
      ).scroll_into_view(
        selector: dom_id(@message),
        behavior: "smooth"
      ).set_value(
        selector: "#message_input",
        value: ""
      ).broadcast
  end

  def update_typing_feedback(html=nil)
    cable_ready["messages"].inner_html(
      selector: "#typing",
      html: html || render_feedback
    ).broadcast
  end

  def render_feedback
    return "" unless typing?

    render(partial: "messages/typing", locals: { user: current_user })
  end

  def typing?
    params[:message][:body].present?
  end

  def no_message?
    params[:message][:body].blank?
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
