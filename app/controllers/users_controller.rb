class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:edit, :update, :index]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy
  def create
    if !signed_in?
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App"
        redirect_to @user
      else
        render "new"
      end
    else
      flash[:notice] = "There is no need to Sign up"
      redirect_to root_path
    end
  end
  def new
    if signed_in?
      flash[:notice] = "There is no need to Sign up"
      redirect_to root_path
    else
      @user = User.new
    end
  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash.now[:success] = "Changes have been saved"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_path
  end
  private 
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      store_location
      flash[:notice] = "Not allowed!"
      redirect_to signin_path#(@current_user)
    end
  end
  def admin_user
    unless current_user.admin? && !current_user?(User.find(params[:id]))
      flash[:notice] = "Not allowed!"
      redirect_to root_path
    end
  end
end
