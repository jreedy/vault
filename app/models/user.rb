class User < ActiveRecord::Base
  validates :username, :presence => true, :length => { :within => 3..25 }
  validates :password, :presence => true, :on => :create
  validates :password, :confirmation => true, :length => { :within => 6..25 }, :allow_blank => true
  
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation, :role_one, :role_two, :role_three
  
  before_save :encrypt_password
  
  private
  def encrypt_password
    self.encrypted_password = Digest::SHA1.hexdigest(password)
  end
  
end
