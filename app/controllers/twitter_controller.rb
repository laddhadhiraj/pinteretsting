class TwitterController < ApplicationController
	before_action :set_client,  except: [:oauth_connect, :oauth_callback]
	CALLBACK_URL = "/tw/oauth/callback"

	 # production
	 TWconfig = {
	 			'consumer_key' => 'PdYhbh28bjr8HxSifXSojhFvO',
	 			'consumer_secret' =>'N6vrELYaNXhp9bM4F1F7yTaEYcyvYkTCOsGK5nvvrsOQlViXU6'
	 			 }

	 # # loal
	 # TWconfig = {
	 # 			'consumer_key' => 'PFI4ZSzBOiCqRaDCIrBemQIP0',
	 # 			'consumer_secret' =>'ZvwwdTuYmshUJPM8kmhQFaleAoWyO2rePeYzPvgK5qKHcOdglA'
	 # 			 }	 			 
	 def oauth_connect

	 	# 	current_user.twitter_token = nil
   # 	current_user.twitter_secret = nil
	  # current_user.save()

	  # session[:tw_access_token] = nil
	  # session[:tw_access_secret] = nil


		if current_user.twitter_token.nil?
			 	c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL
		    client = TwitterOAuth::Client.new(
		        :consumer_key => TWconfig['consumer_key'],
		        :consumer_secret => TWconfig['consumer_secret']
		    )

		    request_token = client.authentication_request_token(:oauth_callback => c)

		    session[:tw_request_token] = request_token.token
		    session[:tw_request_secret] = request_token.secret
		    session[:tw_request] = request_token

   			 redirect_to  request_token.authorize_url

   	 else
   			session[:tw_access_token] = current_user.twitter_token
   			session[:tw_access_secret] = current_user.twitter_secret
   			redirect_to "/tw/user_recent_media"
   	  end	 

	 end

	 def oauth_callback 
  
	 	# render json: request_token 
	 	# return

		c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL

		client = TwitterOAuth::Client.new(
	        :consumer_key => TWconfig['consumer_key'],
	        :consumer_secret => TWconfig['consumer_secret']
   			 )
		
		# request_token = JSON.parse(session[:tw_request_token])

		# render json: request_token["secret"] 
	 	# return
 		
		access_token = client.authorize(
									  session[:tw_request_token],
									  session[:tw_request_secret],
									  :oauth_verifier => params[:oauth_verifier]
									)

   	current_user.twitter_token = access_token.token
   	current_user.twitter_secret = access_token.secret
	  current_user.save()

	  session[:tw_access_token] = access_token.token
	  session[:tw_access_secret] = access_token.secret

	  redirect_to "/tw/user_recent_media"

		# render json: current_user

	 end

	 def user_recent_media
		  @t_user = @client_rest.user('DhirajLaddha')
		  @media = {}

		  @media = @client_rest.search('freebikeproject',{:filter =>'images'})

		  # render json: @media

	 end	 

	 private 

	 def set_client

			# @client_auth = TwitterOAuth::Client.new(
			#     :consumer_key => TWconfig['consumer_key'],
			#     :consumer_secret => TWconfig['consumer_secret'],
			#     :token => session[:tw_access_token],
			#     :secret => session[:tw_access_secret]
			# )
			# render json: @client_auth.authorized?
			# return

			@client_rest = Twitter::REST::Client.new do |config|
			  config.consumer_key        = TWconfig['consumer_key']
			  config.consumer_secret     = TWconfig['consumer_secret']
			  config.access_token        = session[:tw_access_token]
			  config.access_token_secret = session[:tw_access_secret]
			end

	 end

end
