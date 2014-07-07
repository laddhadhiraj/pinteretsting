Rails.application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create'

  get 'social/index'

  resources :orders

  resources :pins

  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'pins#index'
  get 'about' => 'pages#about' # create about_path

  get 'instagram/connect' => 'instagram#oauth_connect'
  get 'fb/connect' => 'facebook#oauth_connect'
  get 'tw/connect' => 'twitter#oauth_connect'

  get 'instagram/show/:id' => 'instagram#show'
  get 'fb/show/:id' => 'facebook#show'
  get 'tw/show/:id' => 'twitter#show'

  get 'oauth/callback' => 'instagram#oauth_callback'
  get 'fb/oauth/callback' => 'facebook#oauth_callback'
  get 'tw/oauth/callback' => 'twitter#oauth_callback'


  get 'nav' => 'instagram#nav'
  get 'user_recent_media' => 'instagram#user_recent_media'
  get 'fb/user_recent_media' => 'facebook#user_recent_media'
  get 'tw/user_recent_media' => 'twitter#user_recent_media'


  get 'user_recent_media/:id' => 'instagram#user_recent_media'
  get 'user_media_feed' => 'instagram#user_media_feed'
  get 'user_media_feed/:id' => 'instagram#user_media_feed'
  get 'location_recent_media' => 'instagram#location_recent_media'
  get 'media_search' => 'instagram#media_search'
  get 'media_popular' => 'instagram#media_popular'
  get 'user_search' => 'instagram#user_search'
  get 'location_search' => 'instagram#location_search'
  get 'location_search_4square' => 'instagram#location_search_4square'
  get 'tags' => 'instagram#tags'
  get 'tags/:id' => 'instagram#tags'
  get 'limits' => 'instagram#limits'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
