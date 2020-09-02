class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.order_created_at.page(params[:page])
                              .per Settings.static_pages.page
  end

  def help; end

  def about; end

  def contact; end
end
