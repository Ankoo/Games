class Game < ActiveRecord::Base
  
  validates_presence_of :title, :description, :genre
  
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
end
