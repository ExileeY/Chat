class ChatRoomsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :set_user,:show]
	before_action :set_user
	before_action :load_entity, only: [:show, :edit, :update, :destroy]
	before_action :require_permission, only: [:edit, :update, :destroy]
	###
	before_action :require_password, only: :show
	###
	
	def index
		@chat_rooms = ChatRoom.all
		if params[:search]
		  @search_term = params[:search]
		  @chat_rooms = @chat_rooms.search_by(@search_term)
		end
	end

	def new
		@chat_room = @user.chat_rooms.new
	end

	def create
		@chat_room = @user.chat_rooms.new(chat_room_params)
		unless @chat_room.save
			render 'new.js'
		end
		###
		generate_room_password
		###
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
		###
	    generate_room_password
		###
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
		params.require(:chat_room).permit(:name, :private_room)
	end

	def require_permission
		if @user != @chat_room.user && (@user.role.blank? || @user.role.vip)
			flash[:danger] = "You haven't got enough permission"
			redirect_to root_path
		end
	end
	###
	def generate_room_password
	  if @chat_room.private_room
	    @chat_room.update(password: (0...8).map { (65 + rand(26)).chr }.join)
	  else
		@chat_room.update(password: nil)
	  end
	end
	###
	###
	def require_password
		if current_user != @chat_room.user && (current_user.role.blank? || current_user.role.vip) && @chat_room.private_room
			if params[:pass] == @chat_room.password
			  if UserRoomPassword.where(user_id: current_user.id, chat_room_id: @chat_room.id).exists?
			    UserRoomPassword.find_by(user_id: current_user.id, chat_room_id: @chat_room.id).update(password: params[:pass])
			  else
				UserRoomPassword.create(user_id: current_user.id, chat_room_id: @chat_room.id, password: params[:pass])
			  end
			end

			if UserRoomPassword.where(user_id: current_user.id, chat_room_id: @chat_room.id).exists?
				pass = UserRoomPassword.find_by(user_id: current_user.id, chat_room_id: @chat_room.id).password
			else
				pass = nil
			end
			
			unless pass == @chat_room.password
				render 'chat_rooms/_check_password'
			end
		end
	end
	###
end
