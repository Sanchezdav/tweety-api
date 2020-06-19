class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_post, only: [:index, :create]
  before_action :set_comment, only: [:update, :destroy]

  def index
    @comments = @post.comments.order(created_at: :desc)

    render json: @comments, include: :user
  end

  def create
    @comment = current_api_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      render json: @comment, include: :user, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end
end
