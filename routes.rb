Rails.application.routes.draw do
  resources :categories do
    resources :tasks
  end

  resources :tasks do
    member do
      post 'complete'
    end
  end

  root "categories#index"  
end
