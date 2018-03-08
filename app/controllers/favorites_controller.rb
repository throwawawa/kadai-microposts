class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id).order('created_at DESC').page(params[:page])
  end
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.favorite(micropost)
    flash[:success] = "投稿にいいねをしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unfavorite(micropost)
    flash[:success] = "いいねを解除しました"
    redirect_back(fallback_location: root_path)
  end
end
