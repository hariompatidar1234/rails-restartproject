class MembersController < ApplicationController
  include JsonWebToken
  # before_action :authenticate_request, except: [:create, :login]
  # before_action  only: [:update, :destroy, :show]
  skip_before_action :verify_authenticity_token#, only: [:create, :login, :update, :destroy, :show]
   # skip_before_action :authenticate_request, only: [:create, :login]
  protect_from_forgery
  def create
    member = Member.new(member_params)
    if member.save
      render json: { message: 'Member created successfully' }, status: :created
    else
      render json: { errors: member.errors.full_messages }
    end
  end

  def login
    if member = Member.find_by(email: params[:email],password: params[:password])
    	token= jwt_encode(member_id: member.id)
    	 render json: { message: "Logged In Successfully..", token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def update
  	member = Member.find(@current_member.id)
    if member.update(member_params)
      render json: { message: 'Member updated successfully' }
    else
      render json: { errors: member.errors.full_messages }
    end
  end

  def destroy
      member=Member.destroy(@current_member.id)
     render json: { message: 'Member deleted successfully' }
  end

  def show
    render json: @current_member
  end

  private

  def member_params
    params.permit(:name, :address, :email, :password, :contact, :role)
  end

  # def set_member
  #   @member = Member.find(params[:id])
  # end
end
