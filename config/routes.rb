Rails.application.routes.draw do
  devise_for :users
  resources :communities do
   resources :events do
     member do
        post "join"
        delete "leave"
     end
   end
   # agregado César
   resources :polls do
      member do
        get "results"
      end
      resources :votes, only: [ :create ]
    end
   resources :posts
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # agregado Luis Inga
  resources :communities do
    resources :events do
      member do
        get :attendees_count
      end
    end
  end
  
  # Agregado por Luis Inga
  resources :communities do
    member do
      get :metrics
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "communities#index"
end
