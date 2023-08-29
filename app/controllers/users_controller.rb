# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_user, only: [:create]
  skip_before_action :check_admin

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'user created successfully' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  def update
    if @current_member.update(user_params)
      render json: { message: 'user updated' }
    else
      render json: { message: 'user not update' }
    end
  end

  def destroy
    if @current_member.destroy
      render json: { message: 'user deleted' }
    else
      render json: { message: 'user deletion failed' }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: @user, status: :ok
    else
      render json: { error: 'user not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :email, :password, :contact)
  end
end
