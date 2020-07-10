class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  validates :username, presence: true, uniqueness: true
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy  
  has_many :favorites, dependent: :destroy
  has_one :role, dependent: :destroy

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.username = data["name"] if user.username.blank?
      end
      if data = session["devise.vkontakte_data"] && session["devise.vkontakte_data"]["extra"]["raw_info"]
      	user.email = data["email"] if user.email.blank?
        user.username = data["name"] if user.username.blank?
        user.password = data["password"] if user.password.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,30]
      user.username = auth.info.name
      user.image = auth.info.image
    end
  end
end
