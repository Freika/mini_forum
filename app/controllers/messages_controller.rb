class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy]
  def index
    @message = current_user.messages.build
    @messages = Message.order(created_at: :desc)
  end

  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      notice = 'Message sent.'
    else
      notice = 'Something went wrong.'
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: notice }
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  def update
    if @message.update(message_params)
      respond_to do |format|
        format.js { render layout: false, content_type: 'text/javascript' }
      end
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Message deleted.' }
      format.js { render layout: false, content_type: 'text/javascript' }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_message
    @message = Message.find(params[:id])
  end
end
