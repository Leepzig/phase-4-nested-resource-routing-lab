class UsersController < ApplicationController

  def show
    find_user
    render json: @user, include: :items
  end

  private
  def find_user
    @user = User.find_by_id(params[:id])
  end
end
