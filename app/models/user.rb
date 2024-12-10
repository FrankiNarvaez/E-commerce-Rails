class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { in: 3..50 }, format: { with: /\A[a-zA-Z\s]+\z/, message: :invalid }
  validates :username, presence: true, length: { in: 3..15 }, format: { with: /\A[a-z0-9A-Z]+\z/, message: :invalid }
  validates :email, presence: true, uniqueness: true, format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
  validates :password, length: { minimum: 6 }

  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :shopping_carts, dependent: :destroy
end
