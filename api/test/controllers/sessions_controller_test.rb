require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  context "#create" do
    should "require username" do
      assert_raises ActionController::ParameterMissing do
        post :create, { username: nil, password: 'test' }
      end
    end

    should "require password" do
      assert_raises ActionController::ParameterMissing do
        post :create, { username: 'test', password: nil }
      end
    end
  end

end
