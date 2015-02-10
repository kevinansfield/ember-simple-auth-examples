require 'test_helper'

class LoginWithEmailAndPasswordTest < ActionDispatch::IntegrationTest

  context "with valid params" do
    should "return authentication token" do
      user = users(:main)

      post '/token', { username: user.email, password: 'testing' }

      assert_response :ok

      # user should have received a new token
      user.reload()

      # returns oauth2 token
      json = JSON.parse response.body
      assert_equal user.authentication_token, json['access_token']
      assert_equal 'bearer', json['token_type']
    end
  end

  context "with invalid params" do
    should "return unauthorized status with error" do
      post '/token', { username: 'unknown', password: 'foo' }
      assert_response :unauthorized

      json = JSON.parse response.body
      assert_equal 'Username or password is invalid', json['error']
    end
  end

end
