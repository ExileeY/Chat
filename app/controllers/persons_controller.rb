class PersonsController < ApplicationController
	before_action :set_user, only: [:profile, :ban, :unban, :check_user_permissions]
	before_action :check_user_permissions, only: [:ban, :unban]
	
	def profile
		@role = Role.new
		@favorites = @user.favorites
	end

	def ban
		@user.update_attributes(banned: true)
	end

	def unban
		@user.update_attributes(banned: false)
	end

	def set_user
		@user = User.find(params[:id])
	end

	private
		def check_user_permissions
			if (current_user.role.blank? || (!@user.role.blank? && !current_user.role.owner && @user.role.owner) ||
											(!@user.role.blank? && current_user.role.admin && @user.role.owner))
				flash[:danger] = "You haven't got enough permissions"
				redirect_to root_path
			elsif (current_user.role.vip || current_user.role.moder)
				flash[:danger] = "User with this status can't do this"
				redirect_to root_path				
			end
		end
end
