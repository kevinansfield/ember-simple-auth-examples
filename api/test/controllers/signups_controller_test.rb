require 'test_helper'

class SignupsControllerTest < ActionController::TestCase

  context "#create" do
    context "with valid params" do
      setup do
        @signup = {
          name: 'Test User',
          email: 'create-test@example.com',
          password: 'password'
        }
      end

      should "create user" do
        assert_difference('User.count') do
          post :create, signup: @signup
        end
      end
    end

    context "with invalid params" do
      setup do
        @signup = { name: '', email: '', password: '' }
      end

      should "should not create user" do
        assert_no_difference('User.count') do
          post :create, signup: @signup
        end
      end
    end
  end

end
