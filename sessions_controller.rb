class SessionsController < ApplicationController  
  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, alert: "Incorrect username or password."
    end
  end

  def delete
    session[:user_id] = nil
    # or session.delete(:user_id)
    redirect_to root_path
  end
  
end
