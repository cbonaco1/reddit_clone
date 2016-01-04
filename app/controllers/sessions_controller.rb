class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(
      params[:session][:username],
      params[:session][:password]
    )

    if user
      sign_in(user)
      #redirect_to subs_url
    else
      flash.now[:errors] = ["Error logging in."]
      render :new
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to new_session_url 
  end

end
