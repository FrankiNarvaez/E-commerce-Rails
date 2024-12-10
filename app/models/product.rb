class Product < ApplicationRecord
  include PgSearch::Model
  include Favoritable

  pg_search_scope :search_full_text, against: { title: "A", description: "B" }

  ORDER_BY = {
    expensive: "price DESC",
    cheapest: "price ASC",
    newest: "created_at DESC",
    oldest: "created_at ASC"
  }

  has_one_attached :photo

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :price, presence: true

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_many :favorites, dependent: :destroy
  has_many :shopping_carts, dependent: :destroy

  def owner?
    user_id == Current.user&.id
  end

  # Found the user asosiated to shopping cart
  def shopping_cart
    shopping_carts.find_by(user: Current.user)
  end
end
