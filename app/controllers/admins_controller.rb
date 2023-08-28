class AdminsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_user
  skip_before_action :check_admin, only: [:create]

  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      render json: { message: 'Admin Created', data: @admin }
    else
      render json: { error: 'admin creation failed' }, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :address, :email, :password, :contact)
  end
end
