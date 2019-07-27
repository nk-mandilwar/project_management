class UsersController < ApplicationController
  before_action :set_developer, only: [:edit, :update]

  def index
    authorize :user 
    developer_role = Role.find_by_internal_identifier 'developer'
    @developers = User.where(role_id: developer_role.id)
  end

  def new
    authorize :user
    @developer = User.new
  end

  def create
    authorize :user
    @developer = User.new(user_params)
    developer_role = Role.find_by_internal_identifier 'developer'
    @developer.role_id = developer_role.id
    if @developer.save
      flash[:notice] = 'Developer added successfully'
      redirect_to edit_user_path(@developer)
    else
      render 'new'
    end
  end

  def edit
    authorize @developer
  end

  def update
    authorize @developer
    if @developer.update_attributes(user_params)
      flash[:notice] = 'Developer updated successfully'
      redirect_to edit_user_path(@developer)
    else
      render 'new'
    end
  end

  private

  def set_developer
    @developer = User.find_by_id params[:id]
  end

  def user_params
    params.require(:user).permit(:employee_id, :email, :password, :password_confirmation)
  end
end