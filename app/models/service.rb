class Service < ActiveRecord::Base
  belongs_to :business
  belongs_to :category
end
