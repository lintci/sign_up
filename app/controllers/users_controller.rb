class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  layout 'admin'

  def index
    authorize @users = User.all
  end

  def show
    authorize @user = User.find(params[:id])
  end

  def update
    authorize @user = User.find(params[:id])

    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
