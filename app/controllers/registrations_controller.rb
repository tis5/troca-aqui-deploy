class RegistrationsController < ApplicationController

  # POST /registrations
  def create
    user = User.create!(
                   email: params['user']['email'],
                   password: params['user']['password'],
                   password_confirmation: params['user']['password_confirmation'],

    )


  if user

    session[:user_id] = user.id

    render json: {
        status: :created,
        user: user
    }
  else

    render json: { status: 418 }

  end

  end


end
