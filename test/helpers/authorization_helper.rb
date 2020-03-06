module AuthorizationHelper
  def sign_up(_user)
    post '/session', params: {
      pseudo: @user[:pseudo],
      password: 'secret'
    }
  end
end
