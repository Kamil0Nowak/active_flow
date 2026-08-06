Rails.application.routes.draw do
  resources :courses do
    member do
      get :manage_enrollments
      post :enroll_to_all
    end
    resources :lessons, except: [ :index, :show ] do
      resources :enrollments, only: [ :create, :destroy, :update ]
    end
  end
  get 'my_courses', to: 'courses#my_courses'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "courses#index"
end
