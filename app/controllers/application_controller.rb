class ApplicationController < ActionController::Base
  helper_method :current_user
  include SessionsHelper
  before_action :login_required

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def authenticate_user
    if logged_in?
      unless current_user.id == @task.user_id
        redirect_to tasks_path, notice:"権限がありません"
      end
    else
      redirect_to new_session_path, notice:"ログインしてください"
    end
  end
end
