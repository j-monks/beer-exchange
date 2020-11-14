class BeersController < ApplicationController

  def index
    @beers = Beer.all
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def update
    @beer = Beer.find(params[:id])
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
    if @beer.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to '/'
    else
      render :new
    end
  end

  private

  def beer_params
    params.require(:beer).permit(:name, :address, :address_line2, :preferences, :phone, :email)
  end
end
