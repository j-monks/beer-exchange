class InformationsController < ApplicationController

  def index
    @information = Information.new
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    @information.user = current_user
    if @information.save
      redirect_to '/'
    else
      render :new
    end
  end

  private

  def information_params
    params.require(:information).permit(:name, :address, :address_line2, :preferences)
  end
end
