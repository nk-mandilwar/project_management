class DashboardPolicy < Struct.new(:user, :dashboard)
  
  def index?
    user.admin?
  end

  def project_todos_status?
    user.admin?
  end

end