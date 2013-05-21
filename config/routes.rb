Atividadescomplementares::Application.routes.draw do
  devise_for :alunos

  resources :atividades

  resources :avaliacoes,
          :only =>
          [
            :listar_atividades_complementares,
            :avaliar_atividade,
            :avaliar,
            :listar_avaliacoes,
            :exibir_avaliacoes
          ],:collection => { :designar => :put }

  as :aluno do
     get "/aluno/sign_in" => "devise/sessions#new", :as => :new_aluno_session
     post "/aluno/sign_in" => "devise/sessions#create", :as => :aluno_session
     get "/aluno/sign_out" => "devise/sessions#destroy", :as => :aluno_session_out
     get "/aluno/home/" => "alunos#home", :as => :aluno_home
     get "/listadeatividades" => "alunos#atividades", :as => :listadeatividades

     match "/selecionar_imagem/:id/selecionar_imagem",:controller => "alunos",:action=>"selecionar_imagem", :as => :selecionar_imagem

     match "/selecionar_imagem/:id/salvar_imagem",:controller => "alunos", :action=>"load_imagem",:as => :salvar_imagem

     match "/selecionar_imagem/:id/remover_imagem",:controller => "alunos", :action=>"remover_imagem", :as => :remover_imagem
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id))(.:format)'
end
