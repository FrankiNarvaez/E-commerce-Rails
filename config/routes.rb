Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :authentication, path: "", as: "" do
    resources :users, only: %i[ new create ], path: "/register", path_names: { new: "/" }
    resources :sessions, only: %i[ new create destroy ], path: "/login", path_names: { new: "/" }
  end

  resources :favorites, only: %i[ index create destroy ], param: :product_id
  resources :shopping_carts, only: %i[ index create destroy update ], param: :product_id
  resources :users, only: %i[ show edit update ], path: "/user", param: :username
  resources :categories, except: :show
  resources :products, path: "/"
end
