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

class User < ActiveRecord::Base

  has_secure_password validations: false

end
