class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.new_user_notification.subject
  #
  def new_user_notification(params)
    @name = params[:name]
    @email = params[:email]
    @password = params[:password]

    mail to: @email , subject: "Welcome aboard"
  end
end
