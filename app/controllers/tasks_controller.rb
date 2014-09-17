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
    @task = Task.create(params[:task])
    binding.pry
    @task.user_id = current_user.id
    # @category = Category.find(params[:category_id])
    # @project = Project.find(params[:project_id])
    # @task.category << @category
    # @task.project << @project

    if @task.save
      if @task.email == ""
        puts "NOT WORKING"
      else        
        Pony.mail({
          :to => "#{@task.email}",
          :via => :smtp,
          :subject => "#{current_user.email}" + "has assigned you a task",
          :body => "Your task is " + "#{@task.description}",
          :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :enable_starttls_auto => true,
            :user_name            => 'skittlemonkey2000',
            :password             => 'tastetherainbow',
            :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
        
            }
          })
        end
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def show
    @category = Category.find_by_user_id(session[:user_id])
    @task = Task.find(params[:id])
    @comment = Comment.new
    @user_comments = Comment.where(task_id: @task.id )
  end

  def edit
    @task = Task.new
    @projects = Project.where(:user_id => current_user.id)
    @categories = Category.where(:user_id => current_user.id)
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to tasks_path
    else
      render "edit"
    end
  end
end
