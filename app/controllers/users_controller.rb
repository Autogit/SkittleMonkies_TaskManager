class UsersController < ApplicationController

  
  skip_before_filter :authorize
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to tasks_path
    else
      redirect_to signup_path, :alert => "Signup Error"
  
  
     
    end
  end
end
