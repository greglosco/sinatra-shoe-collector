class User < ActiveRecord::Base 
  has_secure_password
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  has_many :shoes 
  
  # def slug
  #   username.downcase.gsub(" ","-")
  # end
  
  # def self.find_by_slug(slug)
  #   User.all.find do |user|
  #     user.slug == slug
  #   end
  # end
  
end