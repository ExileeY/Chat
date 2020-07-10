class Users::RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
  	if current_user.provider.nil? && current_user.uid.nil?
      resource.update_with_password(params)
    else
      params.delete("current_password")
      resource.update_without_password(params)
    end
  end
end 