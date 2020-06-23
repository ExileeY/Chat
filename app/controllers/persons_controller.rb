class PersonsController < ApplicationController
	before_action :set_user
	
	def profile
		@role = Role.new
	end

	def set_user
		@user = User.find(params[:id])
	end
end
