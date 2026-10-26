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
        resources :jobs, only: [:index] # все вакансии одной компании
        get 'geeks', to: 'companies#geeks' # все соискатели, заявившиеся на компанию
        member do
          put :mark_deleted # мягкое удаление Глава 7
        end
      end

      resources :jobs do
        resources :applies, only: [:index] # все заявления на вакансию
        get 'geeks', to: 'jobs#geeks' # все соискатели, заявившиеся на вакансию
      end

      resources :geeks do
        resources :applies, only: [:index] # все заявления соискателя
        get 'read_applies', to: 'geeks#read_applies' # все прочитанные заявления
        get 'invited_applies', to: 'geeks#invited_applies' # все приглашения
        member do
          put :resume, to: 'geeks#update_resume' # прикрепить резюме
        end
      end

      resources :applies do
        member do
          put :read, to: 'applies#read_apply' # прочитать заявление
          put :invite, to: 'applies#invite_geek' # пригласить соискателя
        end
      end
    end
  end

  # Обработка 404
  match '*path', to: 'application#catch_404', via: :all
end
