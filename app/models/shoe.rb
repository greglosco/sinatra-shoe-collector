class Shoe < ActiveRecord::Base 
  belongs_to :user 
  belongs_to :category
  
  def slug
    name.downcase.gsub(" ","-")
  end
  
  def self.find_by_slug(slug)
    Shoe.all.find do |shoe|
      shoe.slug == slug
    end
  end
  
end