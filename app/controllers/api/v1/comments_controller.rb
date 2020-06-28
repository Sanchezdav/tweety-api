class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_post, only: [:index, :create]
  before_action :set_comment, only: [:update, :destroy, :like, :dislike]

  def index
    @comments = @post.comments.order(likes_count: :desc, created_at: :desc)

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

  def like
    @comment.likes_count += 1

    if @comment.save
      render head: :ok 
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def dislike
    @comment.dislikes_count += 1

    if @comment.save
      render head: :ok 
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = current_api_user.comments.find(params[:comment_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
