class User < ApplicationRecord
  has_secure_password
  
  before_save :downcase_email
  
  validates :name, presence: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, allow_nil: true
  
  def log_in
    session_token = SecureRandom.urlsafe_base64
    update(session_digest: BCrypt::Password.create(session_token))

    return session_token
  end
  
  def log_out
    update(session_digest: nil)
  end
  
  def authenticated?(token)
    return false if session_digest.nil?

    BCrypt::Password.new(session_digest).is_password?(token)
  end
  
  
  private
    def downcase_email
      self.email = email.downcase
    end
end
