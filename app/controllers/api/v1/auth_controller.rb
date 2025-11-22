class Api::V1::AuthController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [ :sign_up, :login ]

  def sign_up
    user = User.new(user_params)
    if user.save
      token = generate_token(user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user.id)
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def generate_token(user_id)
    secret = Rails.application.secret_key_base
  JWT.encode({ user_id: user_id, exp: 24.hours.from_now.to_i }, secret, "HS256")
  end
end
