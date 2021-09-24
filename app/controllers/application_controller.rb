class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CableReady::Broadcaster
  include MultiDatabase

  add_flash_types :success

  before_action :configure_devise_parameters, if: :devise_controller?

  private

  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def partial(path, options = {})
    { html: render_to_string(partial: path, **options) }
  end
end
