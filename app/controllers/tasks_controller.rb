class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  def index

  end

  def show
    @user = User.find(params[:id])
    @task = @user.tasks.find(params[:id])

  end

  def new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at').page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
    @user = User.find(params[:id])
    @task = @user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:success] = '正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = '削除しました。'
    redirect_back(fallback_location: root_path)

  end

  private

  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
