class PagesController < ApplicationController
  before_action :find_instance, only: [ :mailer ]
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @user = current_user
  end

  def mailer
    @user = current_user
    # ensure that only the owner of the instance can deploy mails
    if @user == @instance.user
      friends = matching_algorithm(@instance)
      friends.each do |sender, receiver|
        UserMailer.beer_email(sender, receiver).deliver_now
      end
      redirect_to '/'
    end
  end

  private
  # TO DO
  # 1 every user can only be picked as a potential recipient once
  # 2 every recipient must be picked once
  # 3 Noone can be matched with themselves

  def matching_algorithm(instance)
    users = []
    instance.beers.map { |beer| users << beer }
    friends = {}
    users.shuffle!
    i = 0
    l = users.length
    while i < l
      if i + 1 != l
        friends[users[i]] = users[i + 1]
      else
        friends[users[i]] = users[0]
      end
      i += 1
    end
    friends
  end


  # This algorithm only works for even numbers of users. it's been kept in in
  # case we want to add an option of different ways of distributing partners down the line.
  # Will set up two and two people with each other.
  # TODO add a solution where it can handle an odd number.
  def pairing_algorithm
    users = User.all
    friends = {}
    i = 0
    while i < length / 2
      num = rand(1 .. users.length)
      friends[users[0]] = users[num]
      friends[users[num]] = users[0]
      users.slice(0, num)
      i++
      friends
    end
    friends
  end

  def find_instance
    @instance = Instance.find(params[:instance_id])
  end

end
