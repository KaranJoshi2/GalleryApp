Rails.application.routes.draw do
  
  devise_for :users

  # get "albums/:id/images/:imageid", to: "albums#delete_image", as: "delete_image"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to:"albums#index"
  
  resources "albums" 
  delete "images/:id", to: "albums#purge", as: "purge_album"
  delete "album/:id", to: "albums#destroyAllImages", as: "delete_all_album"
  get 'tags/:tag', to: 'albums#home', as: "tag"
  get 'my_albums', to: 'albums#my_albums', as: "my_albums"
end
 