class User < ActiveRecord::Base
  attr_reader :password
  validates :username, :session_token, presence: true
  validates :password_digest, presence: { message: "Password cannot be blank" }
  after_initialize :ensure_session_token

  has_many(
    :subs,
    :class_name => "Sub",
    :foreign_key => :moderator_id,
    :primary_key => :id
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :posts,
    :class_name => "Post",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil unless user && user.is_password?(password)
    user
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end


end
