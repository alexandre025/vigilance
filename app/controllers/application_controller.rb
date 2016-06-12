class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :token_authenticate

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    organizations_path
  end

  def token_authenticate
    return if (token = params[:auth_token]).blank?

    if (user = User.find_by_auth_token(token))
      sign_in(user)
    else
    end
    redirect_to url_for(params.except(:auth_token).permit!)
  end
end
