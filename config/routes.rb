Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :images do
    collection do
      get :random
      post :file_upload
    end
  end

  resources :tags
  resources :taggings, only: [] do
    collection do
      get :bulk_new, path: :new
      post :bulk_create
    end
  end

end
