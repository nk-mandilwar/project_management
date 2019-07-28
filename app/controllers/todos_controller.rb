class TodosController < ApplicationController

  before_action :set_todo, except: [:index, :create]

  def index
    authorize :todo 
    @todos = TodoPolicy::Scope.new(pundit_user, "todo").resolve(params)
  end

  def create
    authorize :todo
    @todo = Todo.new(new_todo_params)
    @todo.creator = current_user
    @project = Project.find_by_id(new_todo_params["project_id"])
    if @todo.save
      flash[:notice] = "Todo created successfully"
      redirect_to edit_project_path(@project)
    else
      @todos = @project.todos
      render 'projects/edit'
    end
  end

  def edit
    authorize @todo
    @developers = @todo.project.developers.map{ |developer| [developer.employee_id, developer.id]}
  end

  def update
    authorize @todo
    if @todo.update_attributes(update_todo_params)
      flash[:notice] = 'Todo updated successfully'
      redirect_to edit_project_path(@todo.project)
    else
      render 'edit'
    end
  end

  def update_status
    authorize @todo
    if @todo.progress?
      @todo.status = "done"
    elsif @todo.open?
      @todo.status = "progress"
    end
    @todo.save
    flash[:notice] = "Status updated successfully"
    redirect_to todos_path 
  end

  private

  def set_todo
    @todo = Todo.find_by_id params[:id]
    if @todo.blank?
      flash[:alert] = "Todo does not exist"
      redirect_to todos_path and return
    end
  end

  def new_todo_params
    params.require(:todo).permit(:name, :project_id)
  end

  def update_todo_params
    params.require(:todo).permit(:name, :developer_id)
  end

end