Rails.application.routes.draw do
  resources :vote_results do
    collection do
      post :import
    end
  end

  resources :votes do
    collection do
      post :import
    end
  end
  
  resources :bills do
    collection do
      post :import
    end
  end

  resources :legislators do
    collection do
      post :import
    end
  end

  root 'home#index'
end
