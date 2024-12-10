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

  def destroy
    product.shopping_cart.destroy
    redirect_to shopping_carts_path, notice: t(".destroyed")
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end
end
