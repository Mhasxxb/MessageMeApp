class SessionsController < ApplicationController
  def new
  end
  def create  
    user = User.find_by(username: params[:session][:username])
    check = user && user.authenticate(params[:session][:password])
    if check
      session[:user_id] = user.id
      flash[:success] = "#{user.username.capitalize} have successfully logged in."  
      redirect_to root_path
    else
      flash.now[:error] = "Credentials were incorrect."
      render 'new'
    end 
  end

  def destroy
    
    session[:user_id] = nil
    flash[:success] = "You have logged out successfully"
    redirect_to login_path

  end

end