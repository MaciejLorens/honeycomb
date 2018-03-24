Rails.application.routes.draw do

  root to: 'home#index'

  resources :resources do
    get :download, on: :collection
    get :history, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :resources, only: [:index, :show]
    end
  end

end
