class User < ActiveRecord::Base
  
  belongs_to :role
  
  has_many :posts
  has_many :comments
  has_many :ratings
  
  has_secure_password
  
  validates_uniqueness_of :email
  
end
