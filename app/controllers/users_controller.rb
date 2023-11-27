class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :user_name, :email, :profile, :occupation, :position))
    @user.save
    redirect_to users_path
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @prototype = Prototype.all
    @prototypes = @user.prototypes
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

end
