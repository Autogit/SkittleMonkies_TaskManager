class TasksController < ApplicationController
  
  skip_before_filter :authorize, :only => [:index, :show]
  
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @projects = Project.where(:user_id => current_user.id)
    @categories = Category.where(:user_id => current_user.id)
  end

  def create
    binding.pry
    @task = Task.new(params[:task])
    @task.project_id = (params[:project_id]).to_i
    @task.category_id = (params[:category_id]).to_i
    @task.email = current_user.email
    @task.save
    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find_by_user_id(session[:user_id])
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.new
    @projects = Project.where(:user_id => current_user.id)
    @categories = Category.where(:user_id => current_user.id)
  end

  def update
    @task = Task.find(params[:id])
    @task.project_id = (params[:project_id]).to_i
    @task.category_id = (params[:category_id]).to_i
    if @task.update_attributes(params[:task])
      redirect_to tasks_path
    else
      render "edit"
    end
  end
end
