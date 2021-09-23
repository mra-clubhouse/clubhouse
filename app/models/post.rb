class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all

  validates_presence_of :title, :body, :user
end
