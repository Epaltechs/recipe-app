class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(
      name: food_params[:name],
      measurement_unit: food_params[:measurement_unit],
      price: food_params[:price],
      user_id: current_user.id
    )

    if @food.save
      redirect_to user_foods_path(current_user.id)
      flash[:success] = 'Food saved successfully'
    else
      render :new
      flash.now[:error] = 'Food not saved'
    end
  end

  def destroy
    @food = Food.find(params[:id])

    redirect_to user_foods_path(current_user.id)
    if @food.destroy
      flash[:success] = 'Food deleted successfully'
    else
      flash.now[:error] = 'Food not deleted'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :quantity, :measurement_unit, :price)
  end
end
