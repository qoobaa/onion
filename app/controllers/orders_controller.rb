class OrdersController < ApplicationController
  before_action :require_user

  def index
    @orders = Current.user.orders
  end

  def new
    @order = Current.user.orders.build
  end

  def create
    @order = Current.user.orders.build(order_params)

    if @order.save
      redirect_to orders_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:date, :total, :description)
  end
end
