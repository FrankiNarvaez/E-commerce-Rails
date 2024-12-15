class UsersController < ApplicationController
  skip_before_action :protect_pages, only: :show
  before_action :set_user

  def show
  end

  def edit
    authorize! @user
  end

  def update
    authorize! @user
    if @user.update(user_params)
      redirect_to user_path(@user.username), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.require(:user).permit(:name, :username, :country, :city)
  end
end
