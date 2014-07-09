class AuthenticationsController < ApplicationController
  def create_old
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    render json:authentication
    return
   
  end

   def failure
      flash[:notice] = "User canceled social Sign In."
      sign_in_and_redirect()
    end  

   def create
    auth = request.env["omniauth.auth"]


    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
   
    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    else
      # Authentication not found, thus a new user.

    if(auth['provider'] == 'twitter')
        auth['info']['email'] = auth['provider'] << '_' << auth['uid'].to_s
      end  

      
       
      # If we have already reg. user with this email then login him
      user = User.find_by({email: auth['info']['email'] })

      if !user.nil?
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:user, user)
        return
       end  

      user = User.new
      user.apply_omniauth(auth)
   

      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end
    end
  end
end