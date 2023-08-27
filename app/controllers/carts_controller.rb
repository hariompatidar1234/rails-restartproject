class CartsController < ApplicationController
	 before_action :find_cart, only: [:show, :update, :destroy]
  protect_from_forgery

  # Show all carts
  def index
    carts = Cart.all
    render json: carts
  end

  # Create a cart
  def create
    cart = current_member.carts.build(set_params)
    if cart.save
      render json: cart, status: :ok
    else
      render json: { errors: cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update a cart
  def update
    if @cart.update(set_params)
      render json: @cart
    else
      render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Show a particular cart
  def show
    render json: @cart
  end

  # Delete a cart
  def destroy
    if @cart.destroy
      render json: { message: 'Cart has been deleted' }
    else
      render json: { message: 'Cart not deleted' }
    end
  end

  private

  def set_params
    params.permit(:quantity, :book_id)
  end

  def find_cart
    @cart = Cart.find_by_id(params[:id])
    unless @cart
      render json: 'Cart not found'
    end
  end
end
