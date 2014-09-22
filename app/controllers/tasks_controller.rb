class TasksController < ApplicationController
  
  skip_before_filter :authorize, :only => [:index, :show]
  
  def index
    if current_user.nil?
      redirect_to signup_path, :alert => "You need to log in to do that."
    else
      @tasks = current_user.tasks
      @categories = current_user.categories
    end
  end

  def new
    @task = Task.new
    @projects = Project.where(:user_id => current_user.id)
    @categories = Category.where(:user_id => current_user.id)
  end

  def create
    @task = Task.new(params[:task])
    @user = User.find_by_id(session[:user_id])
    @task.project_id = (params[:project_id]).to_i
    @task.category_id = (params[:category_id]).to_i
    @task.user_id = current_user.id
    
    if @task.save
      @task.create_activity :create, owner: current_user
      TaskMailer.assign_task(@user, @task).deliver if @task.email != ""
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find_by_user_id(session[:user_id])
    @task = Task.find(params[:id])
    @comment = Comment.new
    @user_comments = Comment.where(task_id: @task.id)
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
