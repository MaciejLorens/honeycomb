Rails.application.routes.draw do
  root to: 'resources#index'
  resources :resources do
    get :history, on: :member
  end
end
