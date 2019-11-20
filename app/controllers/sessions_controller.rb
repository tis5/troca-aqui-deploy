class SessionsController < ApplicationController


  def create
    @user = User
               .find_by(email: params["user"]["email"])
               .try(:authenticate,params["user"]["password"])


    if @user
      $user=@user
      render json: {
          status: :created,
          logged_in: true,
          user: @user

      }
    else
      render json: {status: 418}
    end
  end

  def logged_in

      if $user && $user!=0
        render json: {status: 200, logged_in: true}
      else render json: {status: 200, logged_in: false}

      end


  end

  def logout
    $user=0.as_json
    render json: {status: 200, logged_out: true}
  end

end