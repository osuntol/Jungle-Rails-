class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def create  
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
        redirect_to root_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
   session[:user_id] = nil 
    redirect_to root_path, notice: "Signed out."
  end

  def new

  end

end
