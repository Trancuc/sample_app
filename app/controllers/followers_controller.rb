class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t "global.follower"
    @users = @user.followers.page(params[:page])
                  .per Settings.users_controller.page
    render "users/show_follow"
  end
end
