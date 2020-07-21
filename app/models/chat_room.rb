class ChatRoom < ApplicationRecord
	belongs_to :user
	has_many :messages, dependent: :destroy
	has_many :favorites, dependent: :destroy
    has_many :user_room_passwords, dependent: :destroy
    has_many :user_mutes, dependent: :destroy
	validates :name, presence: true, length: {minimum: 5, maximum: 29}
	validates :password, length: {minimum: 8}, allow_nil:true

	def self.search_by(search_term)
	  where("LOWER(name) LIKE :search_term", search_term:"%#{search_term.downcase}%")
	end
end
