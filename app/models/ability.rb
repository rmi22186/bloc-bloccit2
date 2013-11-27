class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new           # is 'user' a specific term for cancan here?  If I passed in x, how would cancan know that x is to determine if it's a user or not?
    if user.role? :member         # if user's role is a member...he can manage posts and comments, but only for his only user id
      can :manage, Post, :user_id => user.id # is this Post and not posts because Post refers to the entire table whereas posts refers to just a single post?
      can :manage, Comment, :user_id => user.id # same question
      can :destroy, Post, :user_id => user.id   #is this needed if manage is already there? - YES, manage does not include destroy
      can :destroy, Comment, :user_id => user.id #is this needed if manage is already there? - YES, manage does not include destroy
      can :create, Vote
      can :manage, Favorite, :user_id => user.id
      can :read, Topic, public:true
    end

    if user.role? :moderator
        can :destroy, Post
        can :destroy, Comment
    end

    if user.role? :admin
        can :manage, :all
    end

    can :read, Topic, public: true
    can :read, Post


  end
end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
