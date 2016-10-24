class User < ActiveRecord::Base
  has_many :tasks
  validates :uid, presence: true, uniqueness: { scope: :provider, message: "Cannot have multiple users from the same provider with the same User ID"}
  validates :provider, presence: true
  validates :email, presence: true

  def self.build_from_github(auth_hash)
    user       = User.new
    user.uid   = auth_hash['uid']
    user.provider = 'github'
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']

    return user
  end
end
