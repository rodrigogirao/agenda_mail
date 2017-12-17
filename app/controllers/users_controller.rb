class UsersController < ApplicationController

  before_action :set_user, except: [:index]

  def edit

  end

  def update
    if user_params[:password].blank? || user_params[:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      bypass_sign_in(@user) # não desloga usuário se alterar senha
      redirect_to messages_path, notice: 'Perfil editado com sucesso.'
    else
      redirect_to edit_user_path(id: @user.id), flash: {danger: 'Houve um erro.'}
    end
  end

  def index
    @users = User.normal
  end

  def messages
    @user = User.find(params[:id])
    @sent = Message.sent_from(@user)
    @received = Message.sent_to(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
      )
  end

end
