class ChatRoomsController < ApplicationController
	def index
		@chat_room = ChatRoom.new
	end
end
