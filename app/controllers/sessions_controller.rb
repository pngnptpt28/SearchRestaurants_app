class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if
      user && user.authenticate(params[:session][:password])
      # by SessionHelper
      log_in user
      redirect_to user
    else
      flash.now[:danger] = '!'
      render 'new'
    end
  end

  def destroy
    # by SessionHelper
    log_out
    redirect_to root_url
  end
end