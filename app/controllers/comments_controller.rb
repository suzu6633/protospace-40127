class CommentsController < ApplicationController
  before_action :set_prototype, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    Comment.create(comment_params)
    redirect_to "/prototypes/#{@comment.prototype.id}"
    @comment.save

  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  def comment_params
    params.require(:comment).permit(:comment_content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
