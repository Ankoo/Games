class Post < ActiveRecord::Base
  
  validates_presence_of :body, :title
  
  belongs_to :user
  belongs_to :game
  
  has_many :comments, dependent: :destroy
  has_many :ratings
  
  
  def average_rating
    return 0 if ratings.size == 0
    ratings.sum(:score) / ratings.size
  end
  
  
end
