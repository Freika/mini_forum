class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    # user_friends(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def user_friends(auth)
    # Parse user's friends and create them.
    access_token = request.env['omniauth.auth']['credentials'].token

    if access_token.present?
      graph = Koala::Facebook::API.new(access_token)

      friends = graph.get_connections('me', 'taggable_friends')

      # Create friends?
    end
  end
end
