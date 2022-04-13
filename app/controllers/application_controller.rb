class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
           devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
           devise_parameter_sanitizer.permit(:account_update, keys: [:name, :admin])
            #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :admin) }
            #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
        end
    

end
