class User < ActiveRecord::Base
  has_many :businesses
  has_many :reviews

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true, length: { in: 8..30 }, on: :create

  has_secure_password validation: false

  def first_review?(business_id)
    reviews.find_by(business_id: business_id).blank?
  end

  def generate_avatar(size)
    "http://api.adorable.io/avatar/#{size}/#{email}".html_safe
  end
end
