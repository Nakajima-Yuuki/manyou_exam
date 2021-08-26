class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expiration_date: :desc).page(params[:page]).per(20)
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :desc).page(params[:page]).per(20)
    elsif  
      @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(20)
    end
    
      #もし渡されたパラメータがタイトルとステータス両方だったとき
    if params[:name].present? && params[:status].present?
      @tasks = Task.search_name(params[:name]).search_status(params[:status]).page(params[:page]).per(20)
      #もし渡されたパラメータがタイトルのみだったとき
    elsif params[:name].present? 
      @tasks = Task.search_name(params[:name]).page(params[:page]).per(20)
      #もし渡されたパラメータがステータスのみだったとき
    elsif params[:status].present? 
      @tasks = Task.search_status(params[:status]).page(params[:page]).per(20)
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
  params.require(:task).permit(:name, :description, :expiration_date, :status, :priority,)
  end

  def set_task
  @task = Task.find(params[:id])
  end
end
