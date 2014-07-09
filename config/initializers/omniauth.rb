 			 
ENV['FACEBOOK_KEY'] = '894113433938989'
ENV['FACEBOOK_SECRET'] = '92493c140204f74202606cd135ab6ab0'
ENV['TWITTER_KEY'] = 'PFI4ZSzBOiCqRaDCIrBemQIP0'
ENV['TWITTER_SECRET'] = 'ZvwwdTuYmshUJPM8kmhQFaleAoWyO2rePeYzPvgK5qKHcOdglA'
ENV['LINKEDIN_KEY'] = '758swiusxua4zu'
ENV['LINKEDIN_SECRET'] = 'sPLlhBnMZlvpKs92'
ENV['GOOGLE_CLIENT_ID'] = '735169237677-cfsvbqa4gmqvuobcf3legj2amc6pferq.apps.googleusercontent.com'
ENV['GOOGLE_CLIENT_SECRET'] = '1q8oliSGLPu5wh1gMSlZb_Rg'

# heroku config:add LINKEDIN_KEY='75yhsygwuq87vi' LINKEDIN_SECRET='3nlbqM9Gi3ZnKK4k' FACEBOOK_KEY='533011503477554' FACEBOOK_SECRET='240444b885ade0fc4e1f5b54b815a98d' TWITTER_KEY='Tp9pRlP0LYFSjzHb00C6bK2y4' TWITTER_SECRET='wGpKCkXu0wXyoghC6R21TkNH3ddY3XPA44LeBen0O5PgarYtYE' GOOGLE_CLIENT_ID='735169237677-tdm1ikeute396sm63qe6an69cq0p6khf.apps.googleusercontent.com' GOOGLE_CLIENT_SECRET='CJ3OnN4fBZUfuPQ1O4il7JXi'


Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
    provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']


 
  # If you want to also configure for additional login services, they would be configured here.
end


