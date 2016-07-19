Rails.application.routes.draw do

  root to: 'home#index'

  resources :resources do
    get :history, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :resources, only: [:index] do
        get :history, on: :member
      end
    end
  end

end
