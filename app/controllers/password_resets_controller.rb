class PasswordResetsController < ApplicationController
  def new
  end
  def create
    @forgot_user = User.find_by_email(params[:email].downcase)
    if @forgot_user
      UserMailer.password_reset(@forgot_user).deliver
      flash[:success] = "The reset email has been sent"
      redirect_to root_path
    else
      flash[:error] = "Please input your email"
      redirect_to new_password_reset_path
    end
  end
end
