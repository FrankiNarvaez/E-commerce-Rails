class ShoppingCartsController < ApplicationController
  def index
    @pagy, @products = pagy_countless(FindProducts.new.call({ shopping_cart: true }).load_async, limit: 12)
  end

  def create
    if product.shopping_cart.present?
      product.shopping_cart.update(amount: product.shopping_cart.amount + 1)
    else
      product.shopping_carts.create(user: Current.user, amount: 1)
    end

    redirect_to product_path(product.id), notice: t(".created")
  end

  def update
    if shopping_cart_params[:amount].to_i > 0
      product.shopping_cart.update(shopping_cart_params)
    end
  end

  def destroy
    product.shopping_cart.destroy
    redirect_to shopping_carts_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end

  def shopping_cart_params
    params.permit(:amount)
  end
end
