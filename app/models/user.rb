class User < ApplicationRecord
  validates :session_token, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
