class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def get_developers?
    user.admin?
  end

  def add_developers
    user.admin?
  end
end
