class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Authentication
  include Authorization
  include Language
  include Pagy::Backend

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to products_path, alert: t("not_found")
  end
end
