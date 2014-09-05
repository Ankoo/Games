class Post < ActiveRecord::Base
  
  validates_presence_of :body, :title
  
  belongs_to :user
  belongs_to :game
  
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  
end
