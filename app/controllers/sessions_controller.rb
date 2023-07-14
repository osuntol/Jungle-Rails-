class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [:create, :new]

  def create
    @user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
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
