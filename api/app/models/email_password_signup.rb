class EmailPasswordSignup < ActiveType::Record[User]

  validates :email, presence: true
  validates :password, presence: true
  validates :name, presence: true

end
