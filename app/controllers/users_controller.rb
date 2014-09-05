class UsersController < ApplicationController
  
  def new
   @user = User.new
  end
  
  def index
    @users = User.all
    authorize! :read, @users
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Zarejestrowano!"
    else
      render "new"
    end
  end
   
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
   
  def edit
    @user = User.find(params[:id])
    authorize! :manage, @user
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to games_path, notice: 'Dane użytkownika zostały zmienione.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :rank_id, :role_id)
  end
end
