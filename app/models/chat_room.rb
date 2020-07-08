class ChatRoom < ApplicationRecord
	belongs_to :user
	has_many :messages, dependent: :destroy
	has_many :favorites, dependent: :destroy
	validates :name, presence: true, length: {minimum: 5, maximum: 29}

	def self.search_by(search_term)
	  where("LOWER(name) LIKE :search_term", search_term:"%#{search_term.downcase}%")
	end
end
