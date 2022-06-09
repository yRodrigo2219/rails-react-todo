class User < ApplicationRecord
  has_secure_password
  has_many :todos
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }, case_sensitive: false
  validates :name, presence: true, length: { in: 3..50 }
  validates :password, length: { in: 6..20 }, if: -> { new_record? || !password.nil? }
end
