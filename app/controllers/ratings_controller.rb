class RatingsController < ApplicationController
  before_action :find_rating, only: [:show, :update, :destroy]
  protect_from_forgery

  # Show all ratings
  def index
    ratings = Rating.all
    render json: ratings
  end 

  # Create a rating
  def create
    rating = current_member.ratings.build(set_params)
    if rating.save
      render json: rating, status: :ok
    else
      render json: { errors: rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update a rating
  def update
    if @rating.update(set_params)
      render json: @rating
    else
      render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Show a particular rating
  def show
    render json: @rating
  end

  # Delete a rating
  def destroy
    if @rating.destroy
      render json: { message: 'Rating has been deleted' }
    else
      render json: { message: 'Rating not deleted' }
    end
  end

  private

  def set_params
    params.permit(:rate, :comment, :book_id)
  end

  def find_rating
    @rating = Rating.find_by_id(params[:id])
    unless @rating
      render json: 'Rating not found'
    end
  end
end
