class Product < ApplicationRecord
  include PgSearch::Model

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

  def owner?
    user_id == Current.user&.id
  end
end
