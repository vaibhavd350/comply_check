Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Company Admin Routes
      mount_devise_token_auth_for 'User', at: 'users'
      resources :companies, except: %i[new edit] do
        member do
          patch :resubmit_kyb_application
        end
      end
      ############################

      # Compliance Officer Routes
      resources :kyb_applications, only: %i[index show] do
        member do
          patch :approve
          patch :reject
        end
      end
      ############################
    end
  end
end
