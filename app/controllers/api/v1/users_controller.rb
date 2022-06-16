class Api::V1::UsersController < ApplicationController
  before_action :decode_password, only: [:create, :destroy]
  before_action :authorize_request, except: :create
  before_action :find_user, except: [:create, :index]
  before_action :check_ownership, only: [:update, :destroy]

  # GET /users
  def index
    render json: User.where("username like ?", "%#{params[:search]}%").limit(5).as_json( :only => :username ), status: :ok
  end
  
  # GET /users/{username}
  def show
    if @user.id == @current_user.id
      render json: @user, status: :ok
    else
      render json: @user.as_json( :except => :email ), status: :ok
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      DefaultTodos.create(@user)
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_params.except(:username))
      render json: { errors: @user.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    if @user&.authenticate(params[:password])
      @user.destroy
    else
      render json: { errors: "invalid password" }, status: :unprocessable_entity
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
