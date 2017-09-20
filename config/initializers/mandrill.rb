ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => ENV['MANDRILL_SMTP_PORT'],
  :domain    => "localhost",
  :enable_starttls_auto => true,
  :user_name => ENV["MANDRILL_USERNAME"],
  :password  => ENV["MANDRILL_API_KEY"],
  :authentication => 'login',
}
