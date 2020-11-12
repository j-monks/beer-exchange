class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
  end

  def mailer
    @user = current_user
    if @user.admin
      friends = matching_algorithm
      friends.each do |sender, receiver|
        UserMailer.welcome_email(sender, receiver).deliver_now
      end
    end
  end

  private

  def matching_algorithm
    users = User.all
    potential_friends = User.all
    last = users[-1]
    friends = {}
    users.each do |user|
      num = rand(0 .. potential_friends.length)
      while potential_friends[num] == user && user != last
        num = rand(0 .. potential_friends.length)
      end
      friends[user] = potential_friends[num]
      potential_friends.slice!(num)
      if user == last && potential_friends[num] == user
        matching_algorithm
      end
      friends
    end
    friends
  end

  # This algorithm only works for even numbers of users. Will set up two and two people with each other.
  # TODO add a solution where it can handle an odd number.
  def pairing_algorithm
    users = User.all
    friends = {}
    i = 0
    while i < length / 2
      num = rand(1 .. users.length)
      friends[users[0]] = users[num]
      friends[users[num]] = users[0]
      users.slice!(0, num)
      i++
      friends
    end
    friends
  end

end
