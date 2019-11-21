class SessionsController < ApplicationController

  def create
    user = User
               .find_by(email: params["user"]["email"])
               .try(:authenticate,params["user"]["password"])


    if user
      session[:user_id] = user.id
      set_current_user
      render json: {
          status: :created,
          logged_in: true,
          user: user

      }
    else
      render json: {status: 418}
    end
  end

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def logged_in

      if @current_user
        render json: {status: 200, logged_in: true, user:@current_user}
      else render json: {status: 200, logged_in: false}

      end


  end

  def logout
    reset_session
    render json: {status: 200, logged_out: true}
  end

end
