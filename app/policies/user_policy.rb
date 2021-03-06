class UserPolicy < ApplicationPolicy

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
    user.admin? && record.developer?
  end

  def update?
    user.admin? && record.developer?
  end

end