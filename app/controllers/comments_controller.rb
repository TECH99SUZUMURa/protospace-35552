class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to controller: :prototypes, action: :show, id: @prototype.id
    else
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end