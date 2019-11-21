require 'bootsnap/load_path_cache/core_ext/active_support'
module CurrentUserConcern

  included {before_action :set_current_user}

  def set_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end
end
