class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy
  MESSAGE_REGEX = /\Ad @\w+\s[\s\S]+/
  def create
    if MESSAGE_REGEX.match(params[:micropost][:content])
      @message = current_user.messages.build(params[:micropost])
      if @message.save
        flash[:success] = "Message created!"
        redirect_to root_path
      end
    else
      @micropost = current_user.microposts.build(params[:micropost])
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_path
      else
        @feed_items = current_user.feed.paginate(page:params[:page])
        render 'static_pages/home'
      end
    end
  end
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost has been deleted"
    redirect_to root_path
  end
  def index
    redirect_to root_path
  end
  private 
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root if @micropost.nil?
  end
end
