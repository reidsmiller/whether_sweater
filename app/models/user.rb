class User < ApplicationRecord
  before_create :generate_api_key

  validates_presence_of :email, :password
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :api_key

  has_secure_password

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(12)
      break unless User.exists?(api_key: api_key)
    end
  end
end
