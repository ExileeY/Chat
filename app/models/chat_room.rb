class ChatRoom < ApplicationRecord
	belongs_to :user
	has_many :messages, dependent: :destroy
	validates :name, presence: true, length: {minimum: 5}
end
