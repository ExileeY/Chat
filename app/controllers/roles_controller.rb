class RolesController < ApplicationController
	before_action :find_user, only: [:create, :edit, :update, :common_user_permissions]
	before_action :user_has_role, only: :create
	before_action :common_user_permissions, only: [:create, :update, :destroy]
	before_action :update_destroy_role_permissions, only: [:destroy, :update]

	def create
		@role = Role.new(role_params)
		if @role.save
		  render 'create.js'
		else
		  render 'role_errors.js'
		end
	end

	def edit
		@role = Role.find(params[:id])
	end

	def update
		@role = Role.find(params[:id])
		if @role.update_attributes(role_params)
		  render 'update.js'
		else
	      render 'role_errors.js'
		end
	end

	def destroy
		@role = Role.find(params[:id])
		@user = @role.user
		@user.role.destroy
		flash[:success] = "Role has been removed!"
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

	def common_user_permissions
		if current_user.role.blank? || current_user.role.vip || current_user.role.moder
			flash[:danger] = "You haven't got enough permissions"
			redirect_to root_path
		end
	end

	def update_destroy_role_permissions
		@user_role = Role.find(params[:id])
		if current_user.role.admin && (@user_role.admin || @user_role.owner)
			flash[:danger] = "You haven't got enough permissions"
			redirect_to profile_path(@user_role.user)
		end
	end
end
