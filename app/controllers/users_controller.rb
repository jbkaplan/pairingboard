class UsersController < ApplicationController
  before_filter :skip_password_attribute, only: :update

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if request.xhr?
      render json: {  userName: @user.name,
                      userPhase: @user.current_phase,
                      userPhone: @user.phone_number,
                      userDescription: @user.description }
    else
      @user
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render "new"
    end
  end

  def messages

  end


  def update
   @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :phone_number)
    end

    def edit_user_params
      params.require(:user).permit(:name, :password, :phone_number, :description, :current_phase)
    end

  def skip_password_attribute
    if params[:password].blank?
      params.except!(:password)
    end
  end

end
