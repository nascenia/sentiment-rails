class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :email, :password, :password_confirmation])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_index_path
    else
      super
    end
  end
end
