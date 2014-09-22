class Task < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :description, :status, :task_name, :user_id, :email, :project_id, :category_id
  
  belongs_to :project
  belongs_to :user
  belongs_to :category
  has_many :comments
  
  def send_email(current_user)
    if self.email == ""
      puts "Email field was empty"
    else        
      Pony.mail({
        :to          => "#{self.email}",
        :via         => :smtp,
        :subject     => "#{current_user}" + "has assigned you a task",
        :body        => "Your task is " + "#{self.description}. Check it out at http://skittlemonkey-taskmanager.herokuapp.com/!",
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => ENV['MY_EMAIL'],
          :password             => ENV['PASSWORD_SECRET'],
          :authentication       => :plain,
          :domain               => "localhost.localdomain"    
        }
      })
    end
  end
end
