 			 
Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']

 
  # If you want to also configure for additional login services, they would be configured here.
end


# heroku config:add LINKEDIN_KEY='75yhsygwuq87vi' LINKEDIN_SECRET='3nlbqM9Gi3ZnKK4k' FACEBOOK_KEY='533011503477554' FACEBOOK_SECRET='240444b885ade0fc4e1f5b54b815a98d' TWITTER_KEY='Tp9pRlP0LYFSjzHb00C6bK2y4' TWITTER_SECRET='wGpKCkXu0wXyoghC6R21TkNH3ddY3XPA44LeBen0O5PgarYtYE'