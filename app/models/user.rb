class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  has_many :posts

  before_create :set_member
  mount_uploader :avatar, AvatarUploader

  ROLES = %w[member moderator admin] # does ROLES need to be capitalized?  order of roles is different 
  def role?(base_role) #is it possible to have a role outside of the above?
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role) #why is there an extra ? here
  end

  private

  def set_member
    self.role = 'member'
  end
end