class SessionsController < ApplicationController

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log the user in and redirect to show page of user profile
      reset_session
      log_in user
      redirect_to user
    else
      # render an error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  def new
  end
end
