class Api::V1::MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :validate_token
  before_action :validate_permission, only: [:create,:sent]

  def index
    @messages = params[:permission] == 'master' ? Message.master_messages.ordered : Message.sent_to(@user).ordered
    respond_to do |format|
      format.json { render :json => @messages }
    end
  end

  def sent
    @messages = Message.sent_from(@user).ordered
    respond_to do |format|
      format.json { render :json => @messages }
    end
  end

  def archived
    @messages = Message.archived.ordered
    respond_to do |format|
      format.json { render :json => @messages }
    end
  end

  def show
    @message = Message.find(params[:id])
    if @message.receiver == @user || params[:permission] == 'master'
      if @message.unread? && @message.receiver == @user
        @message.read!
      end
      respond_to do |format|
        format.json { render :json => @message }
      end
    else
      render json: {erro: 'Não autorizado.'}, status: 401
    end
  end

  def archive
    @message = Message.find(params[:id])
    if @message.archived? || @message.receiver != @user
      render json: {erro: 'Mensagem já arquivada, Permissão Negada'}, status: 401
    else
      @message.archived! if (@message.receiver == @user || @user.try(:master?))
      respond_to do |format|
        format.json { render :json => {status: 200, message: 'Mensagem arquivada.'}}
      end
    end
  end

  def archive_multiple
    messages = Message.find(params[:message_ids])
    messages.each do |message|
      message.archived! if (message.receiver == @user || @user.try(:master?))
    end
    respond_to do |format|
      format.json { render :json => {status: 200, message: 'Mensagens arquivadas.'}}
    end
  end

  def create
    user = User.find_by_email(message_params[:receiver_email])
    @message = Message.new(message_params.merge(from: @user.id))
    @message.to = user.id if user
    if @message.save
      respond_to do |format|
        format.json { render :json => {status: 200, message: 'Mensagem enviada com sucesso.'}}
      end
    else
      respond_to do |format|
        format.json { render :json => {status: 422, message: 'Houve um erro.'}}
      end
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

  def validate_token
    @user = params[:token].present? ? User.find_by_token(params[:token]) : nil
    if params[:permission] == 'master' || @user.try(:master?)
      render json: {erro: 'Não autorizado.'}, status: 401 unless params[:token] == Figaro.env.api_key
    else
      render json: {erro: 'Não autorizado.'}, status: 401 unless @user
    end
  end

  def validate_permission
    render json: {erro: 'Não autorizado.'} if params[:permission] == 'master'
  end
end
