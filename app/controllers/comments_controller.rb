class CommentsController < ApplicationController
  
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_post
  before_action :set_game
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  
  load_and_authorize_resource
  
  def index
    @comments = Comment.all
  end
  
  def show
    redirect_to game_post_path(@game, @post)
  end
  
  def create
    authorize! :create, @comment
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @rating = Rating.new
    @rating.score = comment_params[:score].to_i
    @rating.user = current_user
    @rating.post = @post
    authorize! :create, @comment
    respond_to do |format|
      if @comment.save
        @rating.comment = @comment
        @rating.save
        format.html { redirect_to game_post_path(@game, @post), notice: 'Komentarz został dodany.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    @rating = Rating.where(post_id: @post.id, user_id: current_user.id).first 
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def destroy
    authorize! :destroy, @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to game_post_path(@game, @post), notice: 'Komentarz został usunięty.' }
      format.json { head :no_content }
    end
  end
  
  
  
  private 
  
  def set_author
    @author = User.find(@comment.user_id).name
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_game
    @game = Game.find(Post.find(params[:post_id]).game_id)
  end
  
  def comment_params
    params.require(:comment).permit(:title, :body, :post_id, :user_id, :score)
  end
  #
  # def rating_params
  #   params.require(:comment).permit(:score)
  # end
  #
  
end