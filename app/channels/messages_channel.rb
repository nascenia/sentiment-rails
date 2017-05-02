class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def received(payload)
    message = Message.create(chatroom_id: payload["chatroom_id"], content: payload["message"])
    ActionCable.server.broadcast('messages', {message: message.content, chatroom_id: message.chatroom_id})
  end

  def speak(message)
    message = Message.create(conversation_id: message["conversation_id"], body: message["message"], user_id: current_user.id)
    msg = ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    ActionCable.server.broadcast('messages', {message: msg, conversation_id: message.conversation_id})
  end
end
