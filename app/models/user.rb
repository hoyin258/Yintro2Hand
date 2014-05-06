class User < ActiveRecord::Base

  has_many :items
  has_many :comments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  has_secure_password
  validates :facebook_name, presence: true, length: {maximum: 50}
  validates :facebook_id, presence: true
  validates :email, presence: false, format: {with: VALID_EMAIL_REGEX}

  # 建立Random 的Token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 把Token 轉為Sha1 Hash
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_token
    self.token = User.digest(User.new_token)
  end

end
