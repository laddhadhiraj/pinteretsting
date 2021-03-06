class InstagramController < ApplicationController
  
  before_action :set_client, except: [:oauth_connect, :oauth_callback]

	CALLBACK_URL = "/oauth/callback"

 # For production
  Instagram.configure do |config|
    config.client_id = "af57299b8ffb4346991d0b9b972cf75e" 
    config.client_secret = "1299af8e94da4f4b97b9699d19ad88b5" 
  end

# # for lcoalhost
#   Instagram.configure do |config|
#     config.client_id = "0806789b717045e4b6ed231dc3282c0c" 
#     config.client_secret = "d8f063e0bafb489c878af3b402506b7a" 
#   end

def oauth_connect
  if current_user.instagram_token == ''
    c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL
    redirect_to Instagram.authorize_url(:redirect_uri => c)
   else
    session[:access_token] = current_user.instagram_token
    redirect_to "/user_recent_media"
   end 
end

def oauth_callback 
  c = "http://"<< request.host_with_port.to_s() << CALLBACK_URL
  response = Instagram.get_access_token(params[:code], :redirect_uri => c)

  current_user.instagram_token = response.access_token
  current_user.save()

  session[:access_token] = response.access_token
  redirect_to "/user_recent_media"
end

def  nav
  html =
  "<h1>Ruby Instagram Gem Sample Application</h1>
    <ol>
      <li><a href='/user_recent_media'>User Recent Media</a> Calls user_recent_media - Get a list of a user's most recent media</li>
      <li><a href='/user_media_feed'>User Media Feed</a> Calls user_media_feed - Get the currently authenticated user's media feed uses pagination</li>
      <li><a href='/location_recent_media'>Location Recent Media</a> Calls location_recent_media - Get a list of recent media at a given location, in this case, the Instagram office</li>
      <li><a href='/media_search'>Media Search</a> Calls media_search - Get a list of media close to a given latitude and longitude</li>
      <li><a href='/media_popular'>Popular Media</a> Calls media_popular - Get a list of the overall most popular media items</li>
      <li><a href='/user_search'>User Search</a> Calls user_search - Search for users on instagram, by name or username</li>
      <li><a href='/location_search'>Location Search</a> Calls location_search - Search for a location by lat/lng</li>
      <li><a href='/location_search_4square'>Location Search - 4Square</a> Calls location_search - Search for a location by Fousquare ID (v2)</li>
      <li><a href='/tags'>Tags</a>Search for tags, view tag info and get media by tag</li>
      <li><a href='/limits'>View Rate Limit and Remaining API calls</a>View remaining and ratelimit info.</li>
    </ol>"
  render inline: html
end

def user_recent_media

    # client = Instagram.client(:access_token =>  session[:access_token])

     @i_user = @client.user
    html = "<h1>#{@i_user.username}'s recent media</h1>"
    for media_item in @client.user_recent_media
      html << "<img src='#{media_item.images.thumbnail.url}'>"
      @media_item = media_item
      html << "<%= debug @media_item %>"
    end
    html << "<%= debug @user %>"

    # @media = @client.user_recent_media

 if params[:id]
      @media = @client.user_recent_media( 'self',:max_id => params[:id])
   else
    @media = @client.user_recent_media('self')
  end


    @next_page = @media.pagination.next_max_id;
    unless @next_page.nil?
      @next_page = '/user_recent_media/' <<  @next_page.to_s()
     end 

    # render inline: html
    # render json: @next_page
end

def show
  @i_user = @client.user
# 
  @media_item = @client.media_item(params[:id])

  html = "<h1>#{@i_user.username}'s recent media</h1>"
  html << "<%= debug @media_item %>"
  # render inline: html

end

def user_media_feed 
  
   user = @client.user
   @i_user = user

  html = "<h1>#{user.username}'s media feed</h1>"

  if params[:id]
      page_1 =  @client.user_recent_media(777, :max_id => params[:id] )  
   else
    page_1 = @client.user_media_feed(777)
  end
  @media =  page_1

  @next_page = @media.pagination.next_max_id;

  unless @next_page.nil?
    @next_page = '/user_media_feed/' <<  @next_page.to_s()
   end 
  # render json: page_1.pagination.next_max_id

  # page_2_max_id = page_1.pagination.next_max_id
  # page_2 = @client.user_recent_media(777, :max_id => page_2_max_id ) unless page_2_max_id.nil?
  # html << "<h2>Page 1</h2><br/>"
  # for media_item in page_1
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # html << "<h2>Page 2</h2><br/>"
  # for media_item in page_2
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # render inline: html

    render "user_recent_media"
end

def location_recent_media
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Media from the Instagram Office</h1>"
  for media_item in client.location_recent_media(514276)
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  render inline: html
end

def media_search
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of media close to a given latitude and longitude</h1>"
  for media_item in client.media_search("37.7808851","-122.3948632")
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  render inline: html
end

def media_popular
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Get a list of the overall most popular media items</h1>"
  for media_item in client.media_popular
    html << "<img src='#{media_item.images.thumbnail.url}'>"
  end
  render inline: html
end

def user_search
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Search for users on instagram, by name or usernames</h1>"
  for user in client.user_search("instagram")
    html << "<li> <img src='#{user.profile_picture}'> #{user.username} #{user.full_name}</li>"
  end
  render inline: html
end

def location_search
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Search for a location by lat/lng with a radius of 5000m</h1>"
  for location in client.location_search("48.858844","2.294351","5000")
    html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
  end
  render inline: html
end

def location_search_4square
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1>Search for a location by Fousquare ID (v2)</h1>"
  for location in client.location_search("3fd66200f964a520c5f11ee3")
    html << "<li> #{location.name} <a href='https://www.google.com/maps/preview/@#{location.latitude},#{location.longitude},19z'>Map</a></li>"
  end
  render inline: html
end

def tags

  @i_user = @client.user



  tags = @client.tag_search('freebikeproject')
  # html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
  

  if params[:id]
      @media = @client.tag_recent_media(tags[0].name, :max_id => params[:id])
   else
     @media = @client.tag_recent_media(tags[0].name);
  end


 
  # for media_item in client.tag_recent_media(tags[0].name)
  #   html << "<img src='#{media_item.images.low_resolution.url}'>"
  # end
  

  @next_page = @media.pagination.next_max_id;

  unless @next_page.nil?
    @next_page = '/tags/' <<  @next_page.to_s()
   end 

  # render inline: html
  render "user_recent_media"
end

def  limits
  client = Instagram.client(:access_token => session[:access_token])
  html = "<h1/>View API Rate Limit and calls remaining</h1>"
  response = client.utils_raw_response
  html << "Rate Limit = #{response.headers[:x_ratelimit_limit]}.  <br/>Calls Remaining = #{response.headers[:x_ratelimit_remaining]}"

 render inline:  html
end

 private
 def set_client
    @client = Instagram.client(:access_token => session[:access_token])
    if !@client.user
      redirect_to "/instagram/connect"
    end  
 end

end
