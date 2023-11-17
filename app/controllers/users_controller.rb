class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :user_name, :email, :profile, :occupation, :position))
    @user.save
    redirect_to users_path
  end

  def show
    @prototype = Prototype.all
    user_id = params[:id]
    @user = User.find(user_id)
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end
end
