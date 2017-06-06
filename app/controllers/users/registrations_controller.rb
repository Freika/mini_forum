class Users::RegistrationsController < Devise::RegistrationsController
  private

  def account_update_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
