class MessagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def new
    @message = Message.new
  end

  def create
    user = User.find_by_email(message_params[:receiver_email])
    @message = Message.new(message_params.merge(from: current_user.id))
    @message.to = user.id if user

    if @message.save
      redirect_to messages_path , notice: 'Mensagem enviada com sucesso.'
    else
      redirect_to new_message_path, flash: {danger: 'Houve um erro'}
    end
  end

  def index
    @messages = current_user.master? ? Message.master_messages.ordered : Message.sent_to(current_user).ordered
  end

  def show
    @message = Message.find(params[:id])
    if @message.unread? && !current_user.master?
      @message.read!
    end
  end

  def archive
    @message = Message.find_by_title(params[:title])
    @message.archived!

    respond_to do |format|
      format.js
    end
  end

  def archive_multiple
    messages = Message.find(params[:messages_ids])
    messages.each do |message|
      message.archived!
    end

    respond_to do |format|
      format.js
    end
  end

  def sent
    @messages = Message.sent_from(current_user)
  end

  def archived
    @messages = Message.includes(:sender).archived
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
