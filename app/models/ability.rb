class Ability
  include CanCan::Ability

  def initialize(user)
    # alias_action :index, :show, to: :read
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :confirm_user_details, :edit_user_details, :submit_user_details, to: :confirm_user

    if(user.nil?)
      user = User.new
    end

    if user.has_role? :admin
        can :manage, :all
    elsif user.has_role? :manager
        can :crud, Component
        can :crud, Kit
        can :crud, ItemCategory
        can :crud, Item
        # can :crud, Report
        can :steamkits, ItemCategory

        can :confirm_user, Reservation
        can :read, Reservation
        can :show, Reservation
        can :create, Reservation
        can :edit, Reservation do |r|
          r.teacher_id == user.id
        end
        can :update, Reservation do |r|
          r.teacher_id == user.id
        end

        # manager could view dashboard
        can :manage, :dashboard
        # manager could read everything and authroized to access quick links
        can :read, :all
        # manager could access all the home controller actions
        can :manage, :home

        can :crud, School

        # manager could view other users
        can :read, User
        can :show, User

        # manager could change their own info
        can :crud, User do |u|
          u.id == user.id
        end

        can :returns, Reservation
        can :pickup, Reservation


    elsif user.has_role? :volunteer
        can :returns, Reservation
        can :pickup, Reservation

        can :read, Kit
        can :show, Kit

    elsif user.has_role? :teacher
      can :show, User do |u|
        u.id == user.id
      end

      can :update, User do |u|
        u.id == user.id
      end

      can :confirm_user, Reservation

      can :crud, Reservation do |r|
        r.teacher_id == user.id
      end


      can :steamkits, ItemCategory


    else
      can :steamkits, ItemCategory
    end

  end
end
