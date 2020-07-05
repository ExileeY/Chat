module ChatRoomsHelper
	def chat_room_owner?
		current_user == @chat_room.user
	end

	def person_have_role?
		(!current_user.role.blank? && !current_user.role.vip)
	end
end
