class Role < ApplicationRecord
	belongs_to :user
	validate :one_of_three
	private
	  def one_of_three
	  	  errors.add(:base, "You can choose only one role") unless
			  (!vip.blank? && moder.blank? && admin.blank? && owner.blank?) ||
			  (vip.blank? && !moder.blank? && admin.blank? && owner.blank?) ||
			  (vip.blank? && moder.blank? && !admin.blank? && owner.blank?) ||
			  (vip.blank? && moder.blank? && admin.blank? && !owner.blank?)
	  end
end
