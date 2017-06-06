class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :messages

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      first_name = auth.info.name.split.first
      last_name = auth.info.name.split.last

      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = first_name
      user.last_name = last_name
    end
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      email
    end
  end
end
