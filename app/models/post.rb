class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :comments
  has_many :ratings
end
