class ShoppingCartsController < ApplicationController
  def index
  end

  def create
    if product.shopping_cart.present?
      product.shopping_cart.update(amount: product.shopping_cart.amount + 1)
    else
      product.shopping_carts.create(user: Current.user, amount: 1)
    end

    redirect_to product_path(product.id), notice: "Added to cart"
  end

  def destroy
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end
end
