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

class UserTest < ActiveSupport::TestCase

  should "be valid with a blank e-mail" do
    assert_valid User.new
  end

  should "be invalid with a duplicate e-mail" do
    user = User.create(email: 'test@example.com')
    copy_cat = User.new(email: 'test@example.com')
    assert_invalid copy_cat, email: "has already been taken"
  end
  
end
