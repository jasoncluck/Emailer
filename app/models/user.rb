class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  validates_uniqueness_of :email
  has_secure_password
  validates_presence_of :password, :on => :create

  before_create { generate_token(:auth_token) }

  def generate_token(column)
  	begin
  		self[column] = SecureRandom.urlsafe_base64
  	end while User.exists?(columns => self[column])
  end
end
