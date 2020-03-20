module PersonsHelper
	def user_has_chat_rooms?(user)
		ChatRoom.where(user_id: user.id).exists?
	end
end
