class TaskMailer < ActionMailer::Base
  default from: ENV['MY_EMAIL']
  
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to the site")
  end
  
  def assign_task(user, task)
    @task = task
    @user = user
    
    mail to: @task.email, subject: "You've been assigned a task"
  end
end
