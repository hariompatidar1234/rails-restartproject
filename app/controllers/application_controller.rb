class ApplicationController < ActionController::Base
  include JsonWebToken

  before_action :authenticate_request
  before_action :check_admin
  before_action :check_user

  private

  def authenticate_request
    begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = jwt_decode(header)
      @current_member = Member.find(decoded[:member_id])
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: 'No record found..'
  end

  attr_reader :current_member

  def check_admin
    render json: { message: 'You are not admin' } unless @current_member.type == 'Admin'
  end

  def check_user
    render json: { message: 'You are not check_user' } unless @current_member.type == 'User'
  end

  def render_404
    render json: { error: 'Invalid URL' }, status: :not_found
  end
end
