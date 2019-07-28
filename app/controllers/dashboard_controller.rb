class DashboardController < ApplicationController

  before_action :set_nextpage_prevpage

  def index
    authorize :dashboard, :index?
    @data = ::DataManager::Dashboard::Utility.developer_todo_list(params[:page], DEFAULT_LIMIT)
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

end