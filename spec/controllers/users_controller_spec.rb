require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { FactoryBot.create(:user)}


  describe '#edit' do
    before do
      sign_in user
    end

    it 'can be reached' do
      get :edit, params: {id: user.id}
      expect(response).to render_template :edit
    end

    it 'find the user' do
      get :edit, params: {id: user.id}
      expect(assigns(:user)).to eq user
    end
  end

  describe '#update' do
    before do
      sign_in user
    end

    it 'find the user' do
      get :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      expect(assigns(:user)).to eq user
    end

    it 'updates a user info' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      user.reload
      expect([user.name,user.email]).to eq ['Editado','editado@email.com']
    end

    it 'updates user password' do
      patch :update, params: { id: user.id, user: {password: '098765',password_confirmation: '098765'}}
      user.reload
      expect(user.valid_password?('098765')).to eq true
    end

    it 'redirect to success page' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'editado@email.com'}}
      expect(response).to redirect_to messages_path
    end

    it 'redirect to edit on error' do
      patch :update, params: { id: user.id, user: {name: 'Editado',email: 'email.com'}}
      expect(response).to redirect_to edit_user_path(id: user.id)
    end

  end

end
