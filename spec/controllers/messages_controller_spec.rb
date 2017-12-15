require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  let(:user) { FactoryBot.create(:user)}
  let(:user1) { FactoryBot.create(:user)}
  let(:message) { FactoryBot.create(:message,to: user.id)}
  let(:archived_message) { FactoryBot.create(:message,:archived,to: user.id)}

  describe '#new' do
    before do
      sign_in user
    end

    it 'can be reached' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns a new message' do
      get :new
      expect(assigns(:message)).to be_a_new(Message)
    end
  end


  describe '#create' do
    before do
      sign_in user
    end

    it 'create a message' do
      expect {create_message}.to change(Message,:count).by(1)
    end

    it 'redirects to index on success' do
      create_message
      expect(response).to redirect_to messages_path
    end

    it 'not create a message' do
      expect {create_invalid_message}.to_not change(Message,:count)
    end

    it 'redirects to new on error' do
      create_invalid_message
      expect(response).to redirect_to new_message_path
    end
  end

  describe '#index' do
    before do
      sign_in user
    end

    it 'can be reached' do
    get :index
      expect(response).to render_template :index
    end

    it 'list all non archived messages' do
      message
      archived_message
      get :index
      expect(assigns(:messages)).to eq([message])
    end

  end

  describe '#show' do
    before do
      sign_in user
    end

    it 'find the message' do
        get :show , params: {id: message.id}
        expect(assigns(:message)).to eq(message)
      end

    it 'can be reached' do
      get :show, params: {id: message.id}
      expect(response).to render_template :show
    end

    it 'update status to read' do
      get :show , params: {id: message.id}
      message.reload
      expect(message.status).to eq 'read'
    end

    it 'update visualized date' do
      get :show , params: {id: message.id}
      message.reload
      expect(message.visualized).to_not be_nil
    end
  end
end


def create_message
  post :create, params:
        {message: {title: 'Mensagem 1', content: 'Conteudo da mensagem', receiver_email: user1.email}}
end

def create_invalid_message
  post :create, params:
        {message: {title: 'Mensagem 1', content: 'Conteudo da mensagem'}}
end
