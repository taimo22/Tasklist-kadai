class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show]
  def index
  end

  def show
    @user = User.find(params[:id])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.tasks.build(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to '/'
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
