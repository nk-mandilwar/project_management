class TodoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve(params)
      method_name = "resolve_for_#{user.role.internal_identifier}".to_sym
      send(method_name, params)
    end

    def resolve_for_admin params
      Todo.all.includes(:project, :creator, :developer).order(created_at: :desc).page(params[:page])
    end

    def resolve_for_developer params
      user.tasks.includes(:project, :creator).order(created_at: :desc).page(params[:page])
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
    user.admin? && !record.done?
  end

  def update?
    user.admin? && !record.done?
  end

  def update_status?
    user.developer? && record.developer == user && !record.done?
  end
end