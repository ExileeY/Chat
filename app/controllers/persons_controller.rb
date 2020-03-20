class PersonsController < ApplicationController
	before_action :set_user
	
	def profile
	end

	def set_user
		@user = User.find(params[:id])
	end
end
