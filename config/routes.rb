Bloccit1::Application.routes.draw do
  
  get "comments/create"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } #This declaration instructs the redirect to look for a controller in the users/ directory, by the name of omniauth_callbacks_controller.rb [used when signing up with facebook]

  resources :topics do #does this format always set the below resource to be a subcategory of the above one?
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
      match '/up-vote', to: 'votes#up_vote', as: :up_vote
      match '/down-vote', to: 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end

  match "about" => 'welcome#about', via: :get

  root to: 'welcome#index'  #sets default url to welcome/index.html.erb
end