class BeersController < ApplicationController
    def index
    @beer = Beer.new
  end

  def new
    @beer = Beer.new
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.user = current_user
    if @beer.save
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
