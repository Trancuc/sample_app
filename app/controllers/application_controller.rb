class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "global.not_found_user"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "global.please_login"
    redirect_to login_url
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
