class Api::V1::ApiController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  private
  
  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    begin
      secret = Rails.application.secret_key_base
      decoded = JWT.decode(token, secret, true, algorithm: 'HS256')
      @current_user_id = decoded[0]['user_id']
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
  
  def current_user
    @current_user ||= User.find(@current_user_id)
  end
end