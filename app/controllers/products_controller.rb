class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.all.with_attached_photo.order(created_at: :desc).load_async

    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end

    if params[:query_text].present?
      @products = @products.search_full_text(params[:query_text])
    end
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
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to products_path, status: :see_other, notice: t(".destroyed")
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :stock, :photo, :category_id)
    end
end
