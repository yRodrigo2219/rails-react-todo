class User < ApplicationRecord
  has_secure_password
  has_many :todos, dependent: :delete_all
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true, length: { in: 2..20 }
  validates :name, presence: true, length: { in: 2..50 }
  validates :password, length: { in: 6..20 }, if: -> { new_record? || !password.nil? }

  def as_json(options={})
    # nunca retornar o password_digest
    options[:except] ||= [:password_digest]
    if options[:except].kind_of?(Array)
      options[:except] += [:password_digest]
    else
      options[:except] = [:password_digest, options[:except]]
    end
    super(options)
  end

  def public_todos
    todos.where is_public: true
  end

  def private_todos
    todos.where is_public: false
  end
end
