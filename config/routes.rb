Bloccit1::Application.routes.draw do
  
  devise_for :users

  resources :topics do
    resources :posts
  end

  match "about" => 'welcome#about', via: :get

  root to: 'welcome#index'  
end