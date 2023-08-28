class MembersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index create login]
  skip_before_action :check_admin
  skip_before_action :check_user

  def index
    members = Member.all
    render json: members
  end

  def login
    member = Member.find_by(email: params[:email], password: params[:password])
    if user
      token = jwt_encode(member_id: member.id)
      render json: { message: 'Logged In Successfully..', token: token }
    else
      render json: { error: 'Please Check your Email And Password.....' }
    end
  end
end
