class ChatRoomsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :set_user,:show]
	before_action :set_user
	before_action :load_entity, only: [:show, :edit, :update, :destroy]
	before_action :require_permission, only: [:edit, :update, :destroy]
	
	def index
		@chat_rooms = ChatRoom.all
	end

	def new
		@chat_room = @user.chat_rooms.new
	end

	def create
		@chat_room = @user.chat_rooms.new(chat_room_params)
		unless @chat_room.save
			render 'new.js'
		end
		@chat_rooms = ChatRoom.all
	end

	def show
		@message = @user.messages.new
	end

	def edit
	end

	def update
		unless @chat_room.update_attributes(chat_room_params)
			render 'edit.js'
		end
	end

	def destroy
		@chat_room.destroy
		flash[:success] = "Room has been deleted!"

		redirect_to root_path
	end

	def set_user
		@user = current_user
	end

	def load_entity
		@chat_room = ChatRoom.find(params[:id])
	end

	private
	def chat_room_params
		params.require(:chat_room).permit(:name)
	end

	def require_permission
		if @user != @chat_room.user
			flash[:danger] = "You haven't got enough permission"
			redirect_to root_path
		end
	end
end
