class Comment < ActiveRecord::Base
  
  validates_presence_of :title, :body
  
  belongs_to :user
  belongs_to :post
  
  has_one :rating, dependent: :destroy
  
  attr_accessor :score
  
  def author
    self.user.try(:name) || 'nieznany'
  end

  
end
