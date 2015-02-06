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

class User < ActiveRecord::Base

  has_secure_password validations: false

  validates :email,
    uniqueness: { case_sensitive: false },
    unless: "email.blank?"

  before_save :downcase_email

  def self.find_for_database_authentication(username:)
    find_by(email: username.downcase)
  end

  def assign_new_authentication_token!
    self.authentication_token = generate_authentication_token
    save!
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def generate_authentication_token
      loop do
        token = SecureRandom.hex
        break token unless self.class.exists?(authentication_token: token)
      end
    end

end
