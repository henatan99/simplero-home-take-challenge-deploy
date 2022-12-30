class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
  
    def configure_permitted_parameters
      attributes = [:first_name, :last_name, :username]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
    end

    def authenticate_user!
      if user_signed_in?
        super
      else
        redirect_to pages_home_path, :notice => 'if you want to add a notice'
      end
    end
end
