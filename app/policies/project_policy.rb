class ProjectPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def get_developers?
    user.admin? && record.creator == user
  end

  def add_developers?
    user.admin? && record.creator == user
  end
end
