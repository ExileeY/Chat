class MessagesController < ApplicationController
	before_action :set_chat_room
	before_action :find_message, only: [:edit, :update, :destroy]
	before_action :require_permissions, only: [:edit, :update, :destroy]
	def create
		@message = current_user.messages.new(message_params)
		@message.chat_room = @chat_room
		@message.save
	end

	def edit
	end

	def update
		@message.update_attributes(message_params)
	end

	def destroy
		@message.destroy
		redirect_to chat_room_path(@chat_room)
	end

	def set_chat_room
		@chat_room = ChatRoom.find(params[:chat_room_id])
	end

	def find_message
		@message = Message.find(params[:id])
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end

	def require_permissions
		if current_user != @message.user && (current_user.role.blank? || current_user.role.vip)
			  flash[:danger] = "You havent got enough permissions"
			  redirect_to chat_room_path(@chat_room)
		end
	end
end
