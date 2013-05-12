class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard              # grant access to the dashboard
      can :manage, :all
    end

    # Pages
    can :access, Page, :public => true
    can :create, Page, !user.new_record?
    can :manage, Page, :pageable => user

    # Statuses
    can :access, Status do |status|
      user.following? status.owner or user == status.owner
    end
    can :create, Status do |status|
      !user.new_record?
    end
    can :manage, Status, :owner => user
  end
end
