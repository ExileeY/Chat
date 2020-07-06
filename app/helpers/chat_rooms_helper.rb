module ChatRoomsHelper
	def chat_room_owner?
		current_user == @chat_room.user
	end

	def person_have_role?
		(!current_user.role.blank? && !current_user.role.vip)
	end

	def user_favorite_room_is_not_exists?(user, chat_room)
		!Favorite.where(user_id: user.id, chat_room_id: chat_room.id).exists?
	end
end
