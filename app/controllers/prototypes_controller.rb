class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  # before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end 
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image, :comment).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def authorize_user!
    redirect_to root_path
  end

  def check_owner
    # ログインユーザーがプロトタイプのオーナーでなければトップページにリダイレクト
    redirect_to root_path unless current_user == @prototype.user
  end
end
