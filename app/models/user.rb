class User < ApplicationRecord
  before_save { self.email, self.username = email.downcase, username.downcase}
  has_many :articles
  validates :username, presence: true,
                       length: { in: 3..25 },
                       uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  validates :fullname, presence: true, length: { in: 3..50 }
  has_secure_password
end
