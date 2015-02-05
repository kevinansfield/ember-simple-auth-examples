# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           indexed
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class EmailPasswordSignupTest < ActiveSupport::TestCase

  should "require an e-mail" do
    assert_invalid EmailPasswordSignup.new, email: "can't be blank"
  end

  should "require a password" do
    assert_invalid EmailPasswordSignup.new, password: "can't be blank"
  end

  should "require a name" do
    assert_invalid EmailPasswordSignup.new, name: "can't be blank"
  end

  context "#save" do
    context "with valid params" do
      setup do
        @signup = EmailPasswordSignup.new(
          name: 'Test User',
          email: 'test@example.com',
          password: 'password')
      end

      should "create a user" do
        assert_difference('User.count') do
          @signup.save
        end
      end

      should "set the user's password_digest" do
        @signup.save
        refute_empty @signup.password_digest
      end
    end
  end

end
