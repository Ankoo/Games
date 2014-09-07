class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :set_game
  load_and_authorize_resource
  
  def index
    @posts = @game.posts.all
  end
  
  def show
    authorize! :read, @post
    @comments = @post.comments.all
    @rating = Rating.where(post_id: @post.id, user_id: current_user.id).first 
  end
  
  def create
    @post = @game.posts.new(post_params)
    @post.user = current_user
    authorize! :create, @post
    respond_to do |format|
      if @post.save
        format.html { redirect_to @game, notice: 'Recenzja została dodana.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new
    
  end
  
  def edit 
    authorize! :update, @post
  end
  
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Recenzja została zaktualizowana.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    authorize! :destroy, @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Recenzja została usunięta.' }
      format.json { head :no_content }
    end
  end
  
  
  
  private

  def set_author
    @author = User.find(@post.user_id).name
  end

  
  def set_game
    @game = Game.find(params[:game_id])
    #@game = @post.game.id
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:title, :body, :game_id, :user_id)
  end
  
end