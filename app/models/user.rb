class User < ActiveRecord::Base
  validates :username, :presence => true, :length => { :within => 3..25 }
  validates :password, :confirmation => true, :length => { :within => 6..25 }, :if => :validate_password
  
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation, :role_one, :role_two, :role_three
  
  before_save :encrypt_password, :if => :validate_password
  
  private
  def validate_password
    self.new_record? ? true : !self.password.blank?    
  end
  
  def encrypt_password
    return nil if self.password.blank?
    self.encrypted_password = Digest::SHA1.hexdigest(self.password)
  end
  
end
