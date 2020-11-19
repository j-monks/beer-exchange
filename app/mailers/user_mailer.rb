class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'You have registered for beer exchange')
  end

  def beer_email(sender, recipient)
    @sender_beer = sender
    @recipient_beer = recipient
    mail(to: @sender_beer.user.email, subject: 'Information for the beer exchange')
  end
end
