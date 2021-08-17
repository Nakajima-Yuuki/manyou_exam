class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice]="投稿を作成しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"ブログを削除しました！"
  end

  private
  def task_params
  params.require(:task).permit(:name, :description)
  end

  def set_task
  @task = Task.find(params[:id])
  end
end
