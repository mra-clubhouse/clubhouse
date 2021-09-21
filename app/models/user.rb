class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
