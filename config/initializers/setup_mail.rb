ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "railscasts.com",
  :user_name            => ENV['MY_EMAIL'],
  :password             => ENV['PASSWORD_SECRET'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}