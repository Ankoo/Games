class CommentsController < ApplicationController
  
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
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    authorize! :create, @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to game_post_path(@game, @post, @comment), notice: 'Komentarz został dodany.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  private 
  
  def set_author
    @author = User.find(params[:user_id])
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_game
    @game = Game.find(Post.find(params[:post_id]).game_id)
  end
  
  def comment_params
    params.require(:comment).permit(:title, :body, :post_id, :user_id)
  end
end