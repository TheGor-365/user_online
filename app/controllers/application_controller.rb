class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 1.minutes.ago) }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:user_update, keys: [:username])
  end

  def update_last_seen_at
    logger.info "Update last seen at timestamp for user id #{current_user.id}"
    current_user.update_attribute(:last_seen_at, Time.current)
  end

end
