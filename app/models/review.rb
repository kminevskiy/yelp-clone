class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  scope :last_six, -> { order("created_at DESC").last(6) }

  validates :comment, :rating, presence: true

  validates_uniqueness_of :user, scope: :user_id
end
