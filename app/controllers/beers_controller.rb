class BeersController < ApplicationController
  before_action :find_instance
  def index
    @beers = @instance.beers
  end

  # the problem is that there are many beers per user and many beers per instance
  # so this needs to be a little more sophisticated than current_user.beer
  def show
    # The reason for the .first being at the end of the line is that even though there is only
    # a single instance of the beer class that matches the criteria, when you use .where it will
    # always return an active record object, and not an instance of the beer class.
    @beer = Beer.where("instance_id = #{@instance.id} AND user_id = #{current_user.id}").first
  end

  def update
    @beer = Beer.where("instance_id = #{@instance.id} AND user_id = #{current_user.id}").first
    @beer.update!(beer_params)
    redirect_to @beer
  end

  def new
    @beer = Beer.new
    @user = current_user
  end

  def create
    @beer = Beer.new(beer_params)
    @user = current_user
    @beer.user = current_user
    @beer.instance = @instance
    if @beer.save!
      # UserMailer.welcome_email(@user).deliver_now
      redirect_to '/'
    else
      render :new
    end
  end

  private
  def find_instance
    @instance = Instance.find(params[:instance_id])
  end

  def beer_params
    params.require(:beer).permit(:name, :address, :address_line2, :preferences, :phone, :email)
  end
end
