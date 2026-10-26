Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
    namespace :api do
    namespace :v1 do
      resources :companies do
        resources :jobs, only: [:index, :show]
        # Дополнительный маршрут для мягкого удаления
        member do
          put :mark_deleted
        end
      end

      resources :jobs do
        resources :applies, only: [:index]
        # Дополнительный маршрут для поиска
        collection do
          get :search
        end
        member do
          put :mark_deleted
        end
      end

      resources :geeks do
        resources :applies, only: [:index]
        member do
          put :mark_deleted
        end
      end

      resources :applies do
        member do
          put :read_apply
          put :invite_geek
        end
      end

      # Маршрут для обработки 404 ошибок
      match '*path', to: 'application#catch_404', via: :all
    end
  end
end
