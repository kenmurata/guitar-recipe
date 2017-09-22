Rails.application.routes.draw do
  
  # TOP画面
  root 'top#index'
  
  # 全件削除(開発時の一時的な内容。リリース時に削除する)
  delete 'top' => 'top#alldelete'
  
  # CSVからの取り込み
  post 'csv/import' => 'csv#import'

  # ユーザ情報のルーティング
  # (暗黙的にindex,create,new,edit,update,deleteが指定される)
  resources :users do
    member do
      # 購入履歴を表示する
      get :history
    end
  end
  
  resources :events, only: [:index, :new, :create, :edit, :update]
  resources :products, only: [:index, :new, :create, :edit, :update]
  resources :purchases, only: [:index, :new, :create, :edit, :update]
  
  # ユーザ検索
  resources :search, only: [:index] do
    collection do
      # 検索結果の表示
      get :result
    end
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
