class Api::V1::UsersController < ApplicationController
  before_action :decode_password, except: :show
  before_action :authorize_request, except: :create
  before_action :find_user, except: :create
  before_action :check_ownership, only: [:update, :destroy]
  
  # GET /users/{username}
  def show
    if @user.id == @current_user.id
      render json: @user.as_json( :include => [:public_todos, :private_todos] ), status: :ok
    else
      render json: @user.as_json( :except => :email, :include => :public_todos ), status: :ok
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if @user&.authenticate(params[:password])
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
      end
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # DELETE /users/{username}
  def destroy
    if @user&.authenticate(params[:password])
      @user.destroy
    end
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'user not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password
    )
  end
end
