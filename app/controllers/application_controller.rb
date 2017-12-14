class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  private

  def layout_by_resource
    if devise_controller?
      'login'
    else
      'application'
    end
  end
end
