class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :messages

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
end
