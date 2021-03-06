class CommentsController < CooperativeController
  before_action :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @commentable = @comment.commentable || ( not_found and return )
    authorize! :create, @comment
    @comment.save!

    respond_to do |format|
      format.js
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end

private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end