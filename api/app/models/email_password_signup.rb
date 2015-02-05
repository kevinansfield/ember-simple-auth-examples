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

class EmailPasswordSignup < ActiveType::Record[User]

  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true

end
