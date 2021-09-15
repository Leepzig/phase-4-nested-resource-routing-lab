require "pry"
class ItemsController < ApplicationController

  
  def index
    if params[:user_id]
      find_user
      if @user
        # binding.pry
        items = @user.items
        render json: items
      else
        render_not_found
      end
    else
      items = Item.all
      render json: items, include: :user
    end
  end

  def show
    if params[:user_id]
      find_user
      # binding.pry
      if @user
        item = @user.items.find_by_id(params[:id])
        if item
          render json: item
        else
          render_not_found
        end
      else
        render_not_found
      end
    else
      item = Item.find_by_id(params[:id])
      render json: item, include: :user
    end
  end

  def create
    if params[:user_id]
      find_user
      if @user
        item = @user.items.create(item_params)
        render json: item, status: 201
      else
        render_not_found
      end
    end
  end

  private

  def find_user
    @user = User.find_by_id(params[:user_id])
  end

  def render_not_found
    render json: {error: "not found"}, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
