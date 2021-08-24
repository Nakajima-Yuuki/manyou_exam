class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    @tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = Task.all.order(expiration_date: :desc)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice]="タスクを作成しました！"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end 

  def confirm
    @task = Task.new(task_params)
  end

  private
  def task_params
  params.require(:task).permit(:name, :description, :expiration_date,)
  end

  def set_task
  @task = Task.find(params[:id])
  end
end
