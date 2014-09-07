class User < ActiveRecord::Base
  
  Roles = %w[Admin Moderator Standard Banned]
  Ranks = %w[Newbie Noob Casual Pro]
  
  belongs_to :rank
  belongs_to :role
  
  has_many :posts
  has_many :comments
  has_many :ratings
  
  has_secure_password
  
  validates_presence_of :name, :email
  
  validates_uniqueness_of :email
  validates_uniqueness_of :name
  
  before_create :set_default_role
  
  def rank_name
    return "noob" if self.role_name == 'banned'
    self.rank.try(:title) || ""
  end
  
  def rank_id
    self.rank.try(:id) || ""
  end
  
  def role_name
    self.role.try(:name) || "" 
  end
  
  def role_id
    self.role.try(:id) || ""
  end
  
  def admin?
    self.role_name == 'Admin'
  end
  
  def moderator?
    self.role_name == 'Moderator'
  end
  
  def standard?
    self.role_name == 'Standard'
  end
  
  
  private
  
  def set_default_rank
    self.rank ||= Rank.find_by_title('Newbie')
  end
  
  def set_default_role
    self.role ||= Role.find_by_name('Standard')
  end
  
  
    
end
