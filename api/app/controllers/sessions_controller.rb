class SessionsController < ApplicationController

  def create
    user = User.find_for_database_authentication(username: login_params[:username])

    if user and user.authenticate(login_params[:password])
      user.assign_new_authentication_token!
      render json: { access_token: user.authentication_token, token_type: 'bearer'}
    else
      error_msg = 'Username or password is invalid'
      render json: { error: error_msg }, status: :unauthorized
    end
  end

  private

    def login_params
      {
        username: params.require(:username),
        password: params.require(:password)
      }
    end

end
