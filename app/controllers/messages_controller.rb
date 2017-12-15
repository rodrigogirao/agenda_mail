class MessagesController < ApplicationController
  before_action :authenticate_user!
  def new
    @message = Message.new
  end

  def create
    user = User.find_by_email(message_params[:receiver_email])
    @message = Message.new(message_params.merge(from: current_user.id))
    if user
      @message.to= user.id
    end
    if @message.save
      redirect_to messages_path
    else
      redirect_to new_message_path
    end
  end

  def index
    @messages = Message.includes(:sender).sent_to(current_user).ordered
  end

  def show
    @message = Message.find(params[:id])
    if @message.unread?
      @message.read!
    end
  end

  private

  def message_params
    params.require(:message).permit(
      :title,
      :content,
      :from,
      :receiver_email,
      :to,
      :status,
      :response
      )
  end

end
