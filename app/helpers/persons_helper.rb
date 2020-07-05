module PersonsHelper
	def user_has_chat_rooms?(user)
		ChatRoom.where(user_id: user.id).exists?
	end

	def user_have_permissions?(user)
		!current_user.role.nil? && (current_user.role.owner || current_user.role.admin) && user != current_user && !current_user.role.moder && !current_user.role.vip
	end

	def user_have_role?(user)
		!user.role.blank?
	end

	def user_is_current?(user)
		user == current_user
	end
end
