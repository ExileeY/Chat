class MessagesController < ApplicationController
	before_action :set_entity
	before_action :find_message, only: [:edit, :update, :destroy]
	before_action :require_permissions, only: [:edit, :update, :destroy]
	before_action :user_muted?, only: [:create, :edit, :update, :destroy]
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

	def set_entity
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
    # raise mistake if user muted time less then current time (only if user is muted)
	def user_muted?
		if UserMute.where(user_id: current_user.id, chat_room_id: @chat_room.id).exists?
			user_mute = UserMute.find_by(user_id: current_user.id, chat_room_id: @chat_room.id)
			if Time.now >= user_mute.time
				user_mute.destroy
			else
				flash[:danger] = "You can't do this now."
				redirect_to chat_room_path(@chat_room)
			end
		end
	end
end
