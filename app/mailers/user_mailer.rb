class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.price_alert.subject
  #
  def price_alert(alert)
    @alert = alert
    mail to: @alert.user.email
  end
end
