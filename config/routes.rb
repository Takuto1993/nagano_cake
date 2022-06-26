Rails.application.routes.draw do
  namespace :admin do
    get 'orders/show'
  end
  root 'public/homes#top'
  get '/about' =>'public/homes#about'

  get '/customers/mypage' => 'public/customers#show'
  get '/customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch '/customers/withdraw' => 'public/customers#withdraw', as: 'withdrawal'

  delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all', as: 'destroy_all'

  scope module: :public do
    resource :customers, only: [:edit, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders, only: [:index, :new, :create, :show] do
      collection do
        post :confirm
        post :complete
      end
    end
  end

  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :new, :show, :edit, :create, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    get 'homes/top'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
