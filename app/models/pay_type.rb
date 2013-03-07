class PayType < ActiveRecord::Base

	has_one :order
	validates :name, presence: true
end
