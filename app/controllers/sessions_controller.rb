class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #redirect_to "show"
      sign_in user
      #redirect_to current_user
      redirect_back_or current_user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render "new"
    end
  end
  def new
    if signed_in?
      redirect_to root_path
    end
  end
  def destroy
    sign_out
    redirect_to root_path
  end
end
