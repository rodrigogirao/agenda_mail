class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index

  end

  def logged

  end
end
