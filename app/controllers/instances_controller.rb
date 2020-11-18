class InstancesController < ApplicationController
  def index
    @instances = Instance.all
  end

  def show
    @instance = Instance.find(params[:id])
    @beer = Beer.where("instance_id = #{@instance.id} AND user_id = #{current_user.id}").first
  end

  def update
    @instance = current_user.instance
    @instance.update!(instance_params)
    redirect_to @instance
  end

  def new
    @instance = Instance.new
    @user = current_user
  end

  def create
    @instance = Instance.new(instance_params)
    @user = current_user
    @instance.user = current_user
    if @instance.save
      # UserMailer.welcome_email(@user).deliver_now
      redirect_to '/'
    else
      render :new
    end
  end

  private

  def instance_params
    params.require(:instance).permit(:name)
  end
end
