class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      user_friends(request.env['omniauth.auth']) unless Rails.env.test?

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
    access_token = auth['credentials'].token

    return unless access_token.present?

    graph = Koala::Facebook::API.new(access_token)

    friends = graph.get_connections('me', 'taggable_friends')
    names = friends.map { |f| f['name'] }

    ReadCache.redis.sadd("users:friends:#{@user.id}", names)
  rescue
    {}
  end
end
