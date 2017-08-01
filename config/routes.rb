Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root :to => redirect('/login')
    resources :parks, only: [:index, :create, :show, :update, :destroy], :as => :parks
    resources :park_comments, only: [:new, :create, :update, :destroy]
    resources :friendship, only: [:index, :show, :create, :destroy], :as => :friendship
    resources :event_comments, only: [:new, :create, :update, :destroy]
    resources :events
    resources :users, only: %i[create show]
    get '/signup', to: 'users#new', as: :signup
    get 'login', to: 'sessions#new', as: :login
    post '/login', to: 'sessions#create', as: :new_session
    delete '/logout', to: 'sessions#destroy', as: :logout
    get '/friends', to: 'friends#index', as: :index

end
