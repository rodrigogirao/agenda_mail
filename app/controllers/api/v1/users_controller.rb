class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :validate_token
  before_action :validate_master, only: [:index,:messages]
  def index
    @users = User.normal
    respond_to do |format|
      format.json { render :json => @users }
    end
  end

  def messages
    @user = User.find(params[:id])
    @sent = Message.sent_from(@user)
    @received = Message.sent_to(@user)

    respond_to do |format|
      format.json { render :json => {sent: @sent, received: @received} }
    end
  end

  def update

    @user = User.find(params[:id])

    if user_params[:password].blank? || user_params[:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      respond_to do |format|
        format.json { render :json => {status: 200, message: 'Perfil editado com sucesso.'}}
      end
    else
      respond_to do |format|
        format.json { render :json => {status: 422, message: 'Houve um erro.'}}
      end
    end
  end

  private

  def validate_master
    @user = User.find_by_token(params[:token])
    render json: {erro: 'Não autorizado.'}, status: 401 unless @user.try(:master?)
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
      )
  end

  def validate_token
    @user = params[:token].present? ? User.find_by_token(params[:token]) : nil #if token is present search user
    if params[:permission] == 'master' || @user.try(:master?) # if request if for master user check the master api_key
      render json: {erro: 'Não autorizado.'}, status: 401 unless params[:token] == Figaro.env.api_key
    else
      render json: {erro: 'Não autorizado.'}, status: 401 unless @user # if user token exists sets the user for action
    end
  end

end