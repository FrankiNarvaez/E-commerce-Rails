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
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.permit(:name, :username, :country, :city)
  end
end
