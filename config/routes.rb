Rails.application.routes.draw do
  resources :pages

  root :to => 'pages#index', :as => 'home'
end
