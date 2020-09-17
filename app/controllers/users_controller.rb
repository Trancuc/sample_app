class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show create new)
  before_action :find_user, except: %i(create new index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show
    @microposts = @user.microposts.order_created_at.page(params[:page])
                       .per Settings.users_controller.page
  end

  def new
    @user = User.new
  end

  def index
    @users = User.activated.page(params[:page])
                 .per Settings.users_controller.page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "global.text_check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t "global.text_error"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "global.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "global.update_error"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "global.user_delete"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "global.not_found_user"
    redirect_to root_path
  end
end
