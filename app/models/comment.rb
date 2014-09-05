class Comment < ActiveRecord::Base
  
  validates_presence_of :title, :body
  
  belongs_to :user
  belongs_to :post
  
  has_many :ratings
  
  
  def author
    self.user.try(:name) || 'nieznany'
  end
  
end
