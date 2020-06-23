class RolesController < ApplicationController
	before_action :find_user, only: [:create, :edit, :update]
	before_action :user_has_role, only: :create

	def create
		@role = Role.new(role_params)
		if @role.save
		  flash[:success] = "User #{@user.username} change role"
		  redirect_to profile_path(@user)
		else
			redirect_to root_path
		end
	end

	def edit
		@role = Role.find(params[:id])
	end

	def update
		@role = Role.find(params[:id])
		@role.update_attributes(role_params)
		redirect_to profile_path(@user)
	end

	def destroy
		@role = Role.find(params[:id])
		@user = @role.user
		@role.destroy
		flash[:success] = "Role has been removed"
		redirect_to profile_path(@user)
	end

	def find_user
		@user = User.find(params[:user_id])
	end

	private
	def role_params
		params.require(:role).permit(:user_id,:vip,:moder,:admin).merge(user_id: @user.id)
	end

	def user_has_role
		if Role.exists?(user_id: @user.id)
			flash[:info] = "This user has role. You can change it."
			redirect_to root_path
		end
	end
end
