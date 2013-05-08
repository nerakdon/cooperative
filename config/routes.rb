Cooperative::Engine.routes.draw do
  root :to => 'pages#index', :as => 'home'
  match '/pages/home' => redirect('/')
  match '/pages/*path' => 'pages#show', :as => 'show'
  get '/profile' => 'profile#edit', :as => 'profile'
  put '/profile' => 'profile#update'
  get '/notifications' => 'notifications#index', :as => 'notifications'
  resources :status, :only => [:create, :destroy]
  
  resources :people, :only => [:index, :show], :constraints => { :id => /.*/ } do
    resources :follows, :only => [:create, :destroy]
    resources :pages, :except => [:show]
    match 'pages/*path' => 'pages#show', :constraints => {:path => /.+/}, :as => 'show'
  end

  resources :messages, :only => [:index, :show, :new, :create] do
    member do
      get 'reply'
      get 'move_to_trash'
      get 'restore'
    end
    collection do
      get 'sent'
      get 'trash'
    end
  end
end
