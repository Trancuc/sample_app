class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user, only: :create
  before_action :find_relationship, only: :destroy

  def create
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = @relation.followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:followed_id]
    return if @user

    flash[:danger] = t "global.relationships_error"
    redirect_to root_url
  end

  def find_relationship
    @relation = Relationship.find_by id: params[:id]
    return if @relation

    flash[:danger] = t "global.relationships_error"
    redirect_to root_url
  end
end
