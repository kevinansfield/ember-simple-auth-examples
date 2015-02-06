# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string           indexed
#  name                 :string
#  password_digest      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  authentication_token :string           indexed
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should "be valid with a blank e-mail" do
    assert_valid User.new
  end

  should "be invalid with a duplicate e-mail" do
    user = User.create(email: 'test@example.com')
    copy_cat = User.new(email: 'test@example.com')
    assert_invalid copy_cat, email: "has already been taken"
  end

  context ".find_for_database_authentication" do
    should "find user by exact email" do
      user = users(:main)
      assert_equal user, User.find_for_database_authentication(username: user.email)
    end

    should "find user by case-insensitive email" do
      user = users(:main)
      assert_equal user, User.find_for_database_authentication(username: 'TEST@exAMple.COM')

      user = User.create(email: 'CAPS-TEST@example.com')
      assert_equal user, User.find_for_database_authentication(username: 'caps-test@example.com')
    end

    should "return nil for unknown user" do
      assert_nil User.find_for_database_authentication(username: 'unknown@example.com')
    end
  end

  context "#assign_new_authentication_token" do
    should "generate and save new token" do
      user = users(:main)
      old_token = user.authentication_token

      user.assign_new_authentication_token!

      refute_nil user.authentication_token
      refute_equal old_token, user.authentication_token
    end
  end

end
