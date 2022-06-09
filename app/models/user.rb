class User < ApplicationRecord
  has_secure_password
  has_many :todos
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, { in: 3..20 }
  validates :password,
            length: { in: 6..20 },
            if: -> { new_record? || !password.nil? }
end