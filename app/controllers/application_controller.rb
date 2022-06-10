class ApplicationController < ActionController::API

  def not_found
    render json: { error: 'route not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def check_ownership
    if @user.id != @current_user.id
      render json: { errors: "unauthorized" }, status: :unauthorized
    end
  end

  def decode_password
    begin
      params[:password] = Rsa.decode_msg(params[:password])
    rescue => exception
      render json: { error: "unable to decode password" }, status: :unprocessable_entity
    end
  end
end