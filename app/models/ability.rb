class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      elsif user.moderator?
        can :manage, Game
        can :manage, [Post, Comment], user_id: user.id
        can [:read, :create, :destroy], [Post, Comment]
        can :read, User
      elsif user.standard?
        can :manage, Game
        cannot :destroy, Game
        can :read, Post
        can [:create, :update], Post, user_id: user.id
        can :read, Comment
        can [:create, :update], Comment, user_id: user.id
      else
        can :read, [Game, Post, Comment]
      end
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
  end
end
