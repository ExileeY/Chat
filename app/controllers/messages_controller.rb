class MessagesController < ApplicationController
	def create
		@message = current_user.messages.new(message_params)
		if @message.save

		else
		end
	end

	def set_chat_room
		@chat_room = ChatRoom.find(params[:chat_room_id])
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end
end
