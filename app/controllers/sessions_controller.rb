class SessionsController < ApplicationController
  
  def new
  end
  
  def create
   user = User.find_by_email(params[:email])
   if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect_to root_url, notice: "Zalogowano!"
   else
     flash.now.alert = "E-mail lub hasło nieprawidłowe."
   end
  end
  
  def destroy
   session[:user_id] = nil
   redirect_to root_url, notice: "Wylogowano!"
  end
  
end
