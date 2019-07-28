class DashboardController < ApplicationController

  def index
    authorize :dashboard, :index?
    set_nextpage_prevpage
    @data = ::DataManager::Dashboard::Utility.developer_todo_list(params[:page], DEFAULT_LIMIT)
  end

  def projects_todos_status
    authorize :dashboard, :index?
    set_nextpage_prevpage_for_project
    @data = ::DataManager::Dashboard::Utility.project_todo_list(params[:page], DEFAULT_LIMIT)
  end

  private

  def set_nextpage_prevpage
    limit = DEFAULT_LIMIT
    page = params[:page].blank? || params[:page] <= 0 ? 1 : params[:page]
    developer_role_id = Role.find_by_internal_identifier('developer').id
    count = User.where(role_id: developer_role_id).joins(:tasks).select("distinct(users.id)").length
    @next_page = count > (((page - 1) * limit) + limit) ? page + 1 : nil
    @prev_page = page == 1 ? nil : page - 1
  end 

  def set_nextpage_prevpage_for_project
    limit = DEFAULT_LIMIT
    page = params[:page].blank? || params[:page] <= 0 ? 1 : params[:page]
    count = Project.joins(:todos).select("distinct(projects.id)").length
    @next_page = count > (((page - 1) * limit) + limit) ? page + 1 : nil
    @prev_page = page == 1 ? nil : page - 1
  end

end