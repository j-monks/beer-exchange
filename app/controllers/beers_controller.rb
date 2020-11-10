class BeersController < ApplicationController
    def index
    @beer = Beer.new
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beer_params)
    @user = current_user
    @beer.user = current_user
    if @beer.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to '/'
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :address, :address_line2, :preferences)
  end
end
