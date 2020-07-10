module RegistrationsHelper
	def password_required?
		current_user.provider.nil? && current_user.uid.nil?
	end
end