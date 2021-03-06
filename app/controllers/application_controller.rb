class ApplicationController < ActionController::Base
  include Pundit
  
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    if resource.admin?
      root_path
    else
      todos_path
    end
	end

	def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  private

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def user_not_authorized
    flash[:alert] = "Unauthorized"
    if current_user.admin?
      redirect_to root_path
    else
      redirect_to todos_path
    end
  end

end
