Rottenpotatoes::Application.routes.draw do
  resources :movies 
  post '/movies/search_tmdb'
  root :to => redirect('/movies')
    match "movie_add" => "movies#movie_add", :as => "movie_add" 
  
resources :movies do
    match "similar" => "movies#similar"
  end
end
