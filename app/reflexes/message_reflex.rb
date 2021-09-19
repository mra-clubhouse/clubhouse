# frozen_string_literal: true

class MessageReflex < ApplicationReflex
  def send
    return if params[:message][:body].blank?

    @message = Message.new(message_params)
    @message.user_id = current_user.id

    if @message.save
      broadcast_new_message
      # flash[:notification] = "Message was successfully created."
    else
      # flash[:alert] = "Message sending failed."
    end

    update_typing_feedback("")
  end

  def typing
    update_typing_feedback

    morph :nothing
  end

  def load_more(options)
    pp "LOAD MORE!"
    pp options[:timestamp]
    pp options[:limit]
    pp options[:last_id]
    # - Figure out last timestamp (send from client?)
    # - Fetch next X records older than that timestamp
    # - Render them and kick into #messages

    @messages = Message.where("created_at < ?", Time.at(options[:timestamp].to_i)).
      order(:created_at).reverse_order.limit(options[:limit].to_i).load

    # pp @messages.any?
    # pp @messages.count

    chain = cable_ready["messages"]

    chain.outer_html(
      selector: "#intersector",
      html: render(partial: "messages/message", collection: @messages, as: :message)
    ).scroll_into_view(
      selector: "##{options[:last_id]}",
      block: "nearest"
    ) if @messages.any?

    chain.insert_adjacent_html(
      selector: "#messages",
      position: "beforeend",
      html: render(partial: "messages/intersector")
    ) if @messages.count == options[:limit].to_i

    chain.remove(selector: "#intersector") if @messages.none?

    chain.broadcast
  end

  private

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

  def message_params
    params.require(:message).permit(:body)
  end
end
