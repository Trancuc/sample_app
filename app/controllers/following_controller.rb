class FollowingController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t "global.following"
    @users = @user.following.page(params[:page])
                  .per Settings.users_controller.page
    render "users/show_follow"
  end
end
