module Authorization
  extend ActiveSupport::Concern

  included do
    class NotAuthirizedError < StandardError; end

    rescue_from NotAuthirizedError do
      redirect_to products_path, alert: t("not_authorized")
    end

    private

    def authorize!(record = nil)
      is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
      raise NotAuthirizedError unless is_allowed
    end
  end
end
