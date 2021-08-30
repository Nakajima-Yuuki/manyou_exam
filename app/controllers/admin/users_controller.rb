class Admin::UsersController < ApplicationController
    skip_before_action :login_required, only: [:new, :create]
    before_action :admin_user
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    def index
      @users = User.all.includes(:tasks)
    end
    def show
    end
    def new
      @user = User.new
    end
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice:"ユーザーを登録しました"
      else
        render :new
      end
    end
    def edit
    end
    def update
      @user.current_user = current_user
      if @user.update(user_params)
        redirect_to admin_user_path, notice: "ユーザーを更新しました"
      else
        redirect_to admin_users_path, notice: "管理者が１人以上必要のため編集できません"
      end
    end
  
    def destroy
      @user.current_user = current_user
      if @user.destroy
        redirect_to admin_users_path, notice: "ユーザーを削除しました"
      else
        redirect_to admin_users_path, notice: "管理者が１人以上必要のため削除できません"
      end
    end
  
    private
    def user_params
      params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :admin)
    end
    def set_user
      @user = User.find(params[:id])
    end
    def admin_user
      unless current_user.admin?
        flash[:notice] = "管理者以外はアクセスできません"
        redirect_to tasks_path
      end
    end
  end