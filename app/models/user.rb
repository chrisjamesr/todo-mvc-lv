class User < ActiveRecord::Base
  has_secure_password
  validates :email, :presence => true
  validates :email, :uniqueness => true

  # Devise Method
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email =  auth.email
  #     user.password = SecureRandom.hex
  #   end  
  # end



  def self.find_or_create_by_omniauth(auth_hash)
    where(:email => auth_hash["info"]["email"]).first_of_create do |user|
      user.password = SecureRandom.hex
    end  
  end   

end  #  End of Class
