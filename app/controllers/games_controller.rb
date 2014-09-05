class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  def index
   @games = Game.all 
  end
  
  def show
    @post = @game.posts.last 
  end
  
  def new
    @game = Game.new
  end
  
  def edit 
    authorize! :update, @game
  end
  
  def create
    @game = Game.new(game_params)
    authorize! :create, @game
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Gra została stworzona.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Gra została zaktualizowana.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    authorize! :destroy, @game
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Gra została usunięta.' }
      format.json { head :no_content }
    end
  end
  
  
  
  private
  
  def set_game
    @game = Game.find(params[:id])
  end
  
  def game_params
    params.require(:game).permit(:title, :description, :genre)
  end
  
end