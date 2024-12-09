class Favorite < ApplicationRecord
  validates :user, uniqueness: { scope: :product }

  belongs_to :user, default: -> { Current.user }
  belongs_to :product
end
