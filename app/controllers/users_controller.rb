class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update]
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
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      render json: { message: 'user updated successfully' }
    else
      render json: { errors: @user.errors.full_messages }
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user
      @user.destroy
      render json: { message: 'user deleted successfully' }
    else
      render json: { error: 'user deletion failed' }, status: :internal_server_error
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
