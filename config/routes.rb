Rails.application.routes.draw do
  
  devise_for :users

  resources :groups do
    resources :posts do
      resources :comments
    end
    resources :memberships, only: [:create, :destroy]
  end
  get "pages/home"
  root "groups#index"
end
