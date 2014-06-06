class FacebookController < ApplicationController
	 before_action :set_client,  except: [:oauth_connect, :oauth_callback]
	 CALLBACK_URL = "/fb/oauth/callback"



	 # production
	 FBConfig = {
	 			'client_id' => '807447805946364',
	 			'secret_id' =>'5ed07ff561d820b10b762b77d32bb488'
	 			 }

 # # local
	#  FBConfig = {
	#  			'client_id' => '1440708842848360',
	#  			'secret_id' =>'d3dffdf3b874f23d505a3a37e2f4860c'
	#  			 }


	 Koala.config.api_version = "v2.0"

	 def oauth_connect
	 	# current_user.facebook_token = nil
	 	# session[:fb_access_token] =  nil
	 	# current_user.save()
	 	# render json:current_user
	 	# return


	 	if current_user.facebook_token.nil?
 		 	c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL
 		 	@oauth = Koala::Facebook::OAuth.new( FBConfig["client_id"], FBConfig["secret_id"], c)
	 		redirect_to @oauth.url_for_oauth_code({:permissions=>'email,public_profile,,user_photos,read_stream,read_friendlists'})
	 	else
	 		  session[:fb_access_token] =  current_user.facebook_token
    		redirect_to "/fb/user_recent_media"
   	end 	
	 		 
	 end

	 def oauth_callback 
 				c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL
				@oauth = Koala::Facebook::OAuth.new( FBConfig["client_id"], FBConfig["secret_id"], c)
	 		  access_token = @oauth.get_access_token(params[:code])
    
    		session[:fb_access_token] = access_token

    		current_user.facebook_token = access_token
  			current_user.save()
  		 

    		redirect_to "/fb/user_recent_media"

    		
	 end
	 
	 def user_recent_media

	 	@f_user = @graph.get_object("me")
		# @media= @graph.get_connections("me",'photos')

		@media= params[:page] ? @graph.get_page(params[:page]) : @graph.get_connections("me", "photos")

		# page = @graph.get_object(	@media.paging["next"])
		  # @results =   @graph.get_page(@media.next_page_params)


	 	# render json: @media.next_page_params

	 end

	 def show
 		@f_user = @graph.get_object("me")
# 
  	@media_item =  @graph.graph_call(params[:id])  

 
 		# render json: @media_item

	 end

	 def user_media_feed 

	 end

	 def tags

	 end

	 private

 		def set_client
 		if session[:fb_access_token]
  	  @graph = Koala::Facebook::API.new(session[:fb_access_token])
  	 else
  	 	redirect_to "/fb/connect"
  	end
 
 end
	

end
