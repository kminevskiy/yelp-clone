class Business < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, -> { order("created_at DESC") }
  has_many :services
  has_many :categories, through: :services

  validates_presence_of :name, :phone_num, :address, :city, :state, :categories
  validates_uniqueness_of :name

  def rating
    reviews.present? ? reviews.map(&:rating).reduce(:+) / reviews.size.to_f : 0
  end
end
