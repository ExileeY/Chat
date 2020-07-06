class FavoritesController < ApplicationController
	before_action :find_entity, only: [:add_to_favorite, :check_existense]
	before_action :check_existense, only: :add_to_favorite

	def add_to_favorite
		Favorite.create(user_id: @user.id, chat_room_id: @chat_room.id)
		render 'refresh_favorite'
	end

	def delete_from_favorite
		@favorite = Favorite.find(params[:id])
		@user = @favorite.user
		@chat_room = @favorite.chat_room
		@favorite.destroy
		render 'refresh_favorite'
	end

	def find_entity
		@user = current_user
		@chat_room = ChatRoom.find(params[:chat_room_id])
	end

	private

	def check_existense
		if Favorite.where(user_id: @user.id, chat_room_id: @chat_room.id).exists?
			flash[:danger] = "You already have this room in favorites"
			redirect_to root_path
		end
	end
end
