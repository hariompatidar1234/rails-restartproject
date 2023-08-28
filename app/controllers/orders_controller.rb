class OrdersController < ApplicationController
  before_action :find_order, only: %i[show update destroy]
  skip_before_action :check_admin
	skip_before_action :check_user
  protect_from_forgery

  # Show all orders
  def index
    orders = Order.all
    if orders.empty?
      render json: { message: 'No data found' }
    else
      render json: orders
    end
  end

  # Create an order
  def create
    order = @current_member.orders.build(set_params)  # Build the order with the parameters
    book = Book.find_by(id: order.book_id)
  
    if book
      if order.save
        render json: order, status: :ok
      else
        render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Book not found' }
    end
  end
  

  # Update an order
  def update
    if @order.update(set_params)
      render json: @order
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Show a particular order
  def show
    render json: @order
  end

  # Delete an order
  def destroy
    if @order.destroy
      render json: { message: 'Order has been deleted' }
    else
      render json: { message: 'Order not deleted' }
    end
  end

  private

  def set_params
    params.permit(:book_id, :quantity,:member_id)
  end

  def find_order
    @order = Order.find_by_id(params[:id])
    return if @order

    render json: 'order not found'
  end
end
