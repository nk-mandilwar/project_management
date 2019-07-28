class DashboardPolicy < Struct.new(:user, :dashboard)
  
  def index?
    user.admin?
  end

  def projects_todos_status?
    user.admin?
  end

end