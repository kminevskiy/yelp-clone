class Category < ActiveRecord::Base
  has_many :services
  has_many :businesses, through: :services

  before_save :capitalize_name

  def capitalize_name
    self.name = self.name.capitalize
  end
end
