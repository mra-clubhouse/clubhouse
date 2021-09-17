class MessagesChannel < ApplicationCable::Channel
  def subscribed
    return reject if current_user.nil?

    stream_from "messages:user:#{current_user.id}"
  end
end
