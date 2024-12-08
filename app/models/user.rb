class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: { in: 3..50 }, format: { with: /\A[a-zA-Z]+\z/, message: :invalid }
  validates :email, presence: true, uniqueness: true, format: {
      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
      message: :invalid
    }
  validates :password_digest, length: { minimum: 8 }
end
