class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include Pundit::Authorization

  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Nie masz uprawnień do wykonania tej akcji."
    redirect_to(request.referer || root_path)
  end
end
