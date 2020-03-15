module ChatRoomsHelper
	def chat_room_owner?
		current_user == @chat_room.user
	end
end
