class AuthenticationsController < ApplicationController
  
  # Load user's authentications (Twitter, Facebook, ....)
  def index
    @authentications = current_user.authentications if current_user
  end
  
  # Create an authentication when this is called from
  # the authentication provider callback
      def create  
      omniauth = request.env["omniauth.auth"]  
      authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first 
      if authentication  
        flash[:notice] = "Signed in successfully."  
        sign_in_and_redirect(:user, authentication.user)  
      elsif current_user  
        current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])  
        flash[:notice] = "Authentication successful."  
        redirect_to root_url  
      else  
        user = User.new  
    	user.apply_omniauth(omniauth)  
    	if user.save  
      		flash[:notice] = "Signed in successfully."  
      		sign_in_and_redirect(:user, user)  
    	else  
      		session[:omniauth] = omniauth.except('extra')  
      		flash[:notice] = "Sign in with Facebook"
      		redirect_to new_user_registration_url  
    	end  
      end  
    end  
  
  def new
    redirect_to '/auth/facebook'
  end
  
  # Destroy an authentication
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t(:successfully_destroyed_authentication)
    redirect_to root_url
  end
  
  def failure
  	redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end
