class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages, only: %i[ index show ]

  def index
    @categories = Category.order(name: :asc).load_async

    @pagy, @products = pagy_countless(FindProducts.new.call(filter_params).load_async, limit: 12)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to product_path(@product.id), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! @product
  end

  def update
    authorize! @product
    if @product.update(product_params)
      redirect_to product_path(@product.id), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @product
    @product.destroy

    redirect_to products_path, status: :see_other, notice: t(".destroyed")
  end

  private

  def set_product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock, :photo, :category_id)
  end

  def filter_params
    params.permit(:query_text, :min_price, :max_price, :order_by, :page, :favorites, :user_id, :category_id)
  end
end
