class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar, :provider, :uid
  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy

  before_create :set_member
  mount_uploader :avatar, AvatarUploader

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      pass = Devise.friendly_token[0,20]
      user = User.new(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password: pass,
                         password_confirmation: pass
                        )
      user.skip_confirmation!
      user.save
    end
    user
  end



  ROLES = %w[member moderator admin] # does ROLES need to be capitalized?  order of roles is different 
  def role?(base_role) #is it possible to have a role outside of the above?
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role) #why is there an extra ? here
  end

  private

  def set_member
    self.role = 'member'
  end
end