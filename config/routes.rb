Rails.application.routes.draw do
  namespace :admin do
    get 'orders/show'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
  end
  root 'public/homes#top'
  get '/about' =>'public/homes#about'

  get '/items' => 'public/items#index'
  get '/items/:id' => 'public/items#show'

  get '/customers/mypage' => 'public/customers#show'
  get '/customers/edit' => 'public/customers#edit'
  get '/customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch '/customers/withdraw' => 'public/customers#withdraw', as: 'withdrawal'

  get '/cart_items' => 'public/cart_items#index'
  delete '/cart_items/destroy_all' => 'public/cart_items#destroy_all', as: 'destroy_all'

  get '/orders' => 'public/orders#index'

  get '/addresses' => 'public/addresses#index'
  get '/addresses/:id/edit' => 'public/addresses#edit'

  get '/orders/new' => 'public/orders#new'

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :orders

  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :orders
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
