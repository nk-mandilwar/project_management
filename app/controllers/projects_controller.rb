class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :new, :create]

  def index
    authorize :project  
    @projects = Project.includes(:creator).page(params[:page])
  end

  def new
    authorize :project
    @project = Project.new
  end

  def create
    authorize :project
    @project = Project.new(project_params)
    @project.creator = current_user
    if @project.save
      flash[:notice] = "Project created successfully"
      redirect_to edit_project_path(@project)
    else
      render 'new'
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    if @project.update_attributes(project_params)
      flash[:notice] = 'Project updated successfully'
      redirect_to edit_project_path(@developer)
    else
      render 'edit'
    end
  end

  def get_developers
    authorize @project
    developer_role = Role.find_by_internal_identifier 'developer'
    @developers = User.where(role_id: developer_role.id).where.not(id: @project.developers)
  end

  def add_developers
    authorize @project
    @developers = User.where(id: params["developer_ids"])
    @project.developers << @developers
    flash[:notice] = "Developers added successfully"
    redirect_to edit_project_path(@project)
  end

  private

  def set_project
    @project = Project.find_by_id params[:id]
  end

  def project_params
    params.require(:project).permit(:name)
  end

end