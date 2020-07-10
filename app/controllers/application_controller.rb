class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!, except: [:sun, :moon]
	before_action :check_banned, except: :destroy

	def check_banned
		render 'persons/ban_page' if user_signed_in? && current_user.banned == true
	end

	def sun
      cookies.delete(:moon)
      if user_signed_in?
      	redirect_to profile_path(current_user)
      else
      	redirect_to root_path
      end
	end

	def moon
      cookies[:moon] = {
      	value:"Dark mode on"
      }
      if user_signed_in?
      	redirect_to profile_path(current_user)
      else
      	redirect_to root_path
      end
	end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
			devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password])
		end
end
