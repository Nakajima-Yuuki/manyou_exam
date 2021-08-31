class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :other_user, only: [ :show, :edit, :update, :destroy ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(current_user.id)
    else
       render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @task = @user.tasks
  end

  def destroy
    if @user.destroy
      redirect_to new_user_path, notice: "ユーザーを削除しました！"
    else
      redirect_to admin_user_path, notice: "管理者がいなくなる為削除できません"
    end
  end
 
  private
    def user_params
     params.require(:user).permit(:full_name, :email, :password,
                                     :password_confirmation)
    end
    def set_user
      @user = User.find(params[:id])
    end

    def other_user
      unless current_user.id == params[:id].to_i
        flash[:notice] = "権限がありません。"
        redirect_to tasks_path
    end
  end
end