class ProjectsController < ApplicationController

  before_action :set_project, except: [:index, :new]

  def index
    authorize :project  
  end

  def new
    authorize :project
  end

  def create
    authorize @project
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
  end

  def get_developers
    authorize @project
  end

  def add_developers
    authorize @project
  end

  private

  def set_project
    @project = Project.find_by_id params[:id]

end