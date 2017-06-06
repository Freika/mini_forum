class MessagesController < ApplicationController
  def index
    @message = current_user.messages.build
    @messages = Message.order(created_at: :desc)
  end

  def create
    message = current_user.messages.build(message_params)

    if message.save
      notice = 'Message sent.'
    else
      notice = 'Something went wrong.'
    end

    redirect_to messages_path, notice: notice
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
