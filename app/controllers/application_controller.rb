class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Pagy::Backend

  class NotAuthirizedError < StandardError; end

  rescue_from NotAuthirizedError do
    redirect_to products_path, alert: t("not_authorized")
  end

  around_action :switch_locale
  before_action :set_current_user
  before_action :protect_pages

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

  def locale_from_header
    request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
  end

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def protect_pages
    redirect_to new_session_path, alert: t("no_session") unless Current.user
  end

  def authorize!(product)
    is_allowed = product.user_id == Current.user.id
    raise NotAuthirizedError unless is_allowed
  end
end
