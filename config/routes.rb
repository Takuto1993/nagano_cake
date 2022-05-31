Rails.application.routes.draw do
  root 'public/homes#top'
  get '/about' =>'public/homes#about'

  get '/items' => 'public/items#index'
  get '/items/:id' => 'public/items#show'

  get '/customers/mypage' => 'public/customers#show'
  get '/customers/edit' => 'public/customers#edit'
  get '/customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch '/customers/withdraw' => 'public/customers#withdraw', as: 'withdrawal'

  get '/cart_items/:id' => 'public/cart_items#index'

  get '/orders' => 'public/orders#index'

  get '/addresses' => 'public/addresses#index'
  get '/addresses/:id/edit' => 'public/addresses#edit'

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all]

  namespace :public do
    resources :customers, only: [:show, :edit, :update]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all]
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
