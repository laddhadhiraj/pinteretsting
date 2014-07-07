 			 
Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']

 
  # If you want to also configure for additional login services, they would be configured here.
end
