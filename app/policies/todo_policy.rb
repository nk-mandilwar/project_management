class TodoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve(params)
      method_name = "resolve_for_#{user.role.internal_identifier}".to_sym
      send(method_name, params)
    end

    def resolve_for_admin params
      Todo.all.includes(:project, :creator, :developer).page(params[:page])
    end

    def resolve_for_developer params
      user.tasks.includes(:project, :creator).page(params[:page])
    end
  end

  def index?
    user.admin? || user.developer?
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
end