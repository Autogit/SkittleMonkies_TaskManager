class UsersController < ApplicationController
  skip_before_filter :authorize
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      TaskMailer.welcome(@user).deliver
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      redirect_to signup_path, :alert => "Signup Error"
    end
  end
  
  def email
    
  end
end
