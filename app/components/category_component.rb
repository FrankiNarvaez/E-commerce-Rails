# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  def initialize(category: nil)
    @category = category
  end

  def title
    @category ? @category.name : t(".all")
  end

  def link
    @category ? products_path(category_id: @category.id) : products_path
  end

  def active?
    return true if !@category && !params[:category_id]
    @category&.id == params[:category_id].to_i
  end

  def background
    active? ? "text-white bg-main-color border-main-color" : "bg-white"
  end

  def classes
    "category border-2 rounded-xl py-1 px-2 hover:border-main-color #{background}"
  end
end
