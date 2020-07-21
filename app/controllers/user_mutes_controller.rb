class UserMutesController < ApplicationController
  before_action :find_entity
  before_action :user_has_been_muted?, only: :create
  before_action :user_permissions?, only: [:new, :create]

  def new
  	@user_mute = UserMute.new
  end

  def create
  	@user_mute = UserMute.new(user_mute_params)
  	@user_mute.muted = true
  	unless @user_mute.save
  	  render 'new.js'
  	end
    redirect_to chat_room_path(@chat_room)
  end

  private
  def find_entity
  	@user = User.find(params[:user_id])
  	@chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def user_mute_params
  	params.require(:user_mute).permit(:user_id, :chat_room_id, :time)
  end
  # check if user has been muted in this room
  def user_has_been_muted?
  	if UserMute.where(user_id: @user.id, chat_room_id: @chat_room.id).exists?
  		flash[:danger] = "User already has been muted."
  		redirect_to chat_room_path(@chat_room)
  	end
  end
  # raise mistake if user is current user and if current user role is blank or vip
  def user_permissions?
  	if current_user == @user || current_user != @user && 
  	   (current_user.role.blank? || current_user.role.vip)
  	  flash[:danger] = "You haven't got enough permissions."
  	  redirect_to chat_room_path(@chat_room)
  	end
  end
end
