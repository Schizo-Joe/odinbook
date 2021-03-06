class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_requesters, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end

  private

  def authorize_current_user
    return if @user == current_user

    render file: Rails.root.join('public', '401.html'), status: :unauthorized
  end

  def set_requesters
    @requesters = current_user.requesters
  end

  def new_comment
    @comment = current_user.comments.build
  end
end
