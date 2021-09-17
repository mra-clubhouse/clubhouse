# frozen_string_literal: true

class MessageReflex < ApplicationReflex
  def send
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

  private

  def broadcast_new_message
    cable_ready["messages"].insert_adjacent_html(
      selector: "#messages",
      position: "afterbegin",
      html: render(
        partial: "messages/message", locals: { message: @message }
      )
    )
    cable_ready.broadcast
  end

  def update_typing_feedback(html=nil)
    cable_ready["messages"].inner_html(
      selector: "#typing",
      html: html || render_feedback
    )
    cable_ready.broadcast
  end

  def render_feedback
    return "" unless typing?

    render partial: "messages/typing", locals: { user: current_user }
  end

  def typing?
    params[:message][:body].present?
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
