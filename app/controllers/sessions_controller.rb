class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログイン成功した場合
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
end
