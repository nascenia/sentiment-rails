Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'home#index'

  devise_for :users

  resources :conversations, only: [:create] do
    member do
      post :close
    end

    resources :messages, only: [:create]
  end
  resources :admin, only: [:index] do
    collection do
      get :check_sentiments
    end
  end
end
