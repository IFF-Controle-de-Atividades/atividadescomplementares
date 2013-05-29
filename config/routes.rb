#encoding:utf-8
Atividadescomplementares::Application.routes.draw do
  devise_for :avaliadores
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

  as :avaliacoes do
      put "avaliacoes/designar", :as=> :designar 
      get "avaliacoes/listar_atividades_complementares" => "avaliacoes#listar_atividades_complementares", :as => :atividades_complementares
      #get "avaliacoes/avaliar_atividade"
      #get "avaliacoes/avaliar"
      get "avaliacoes/listar_avaliacoes"
      get "avaliacoes/exibir_avaliacoes/:id"=> "avaliacoes#exibir_avaliacoes", :as => :exibir_avaliacoes_complementares
      match "/lista-de-atividades/:id", :controller =>"avaliacoes", :action=>"list", :as=> :listagem_de_atividades_do_aluno_x
      match "/atividades_de/:nome/:id", :controller => "avaliacoes", :action=>"x_list"
      get "/avaliar_atividades/:id",:controller => "avaliacoes", :action=>"x_list", :as=>:x_list
      match "/avaliar_atividade/:id/", :controller => "avaliacoes", :action=>"avaliar_atividade", :as => :avaliar_atividade
      match "/avaliar_atividade/:id/avaliar", :controller => "avaliacoes", :action=>"avaliar", :as => :update_avaliar_atividade
  end

  as :avaliador do
     post "/avaliador/sign_in" => "devise/sessions#create", :as => :avaliador_session
     get "/avaliador/sign_in" => "devise/sessions#new", :as => :new_avaliador_session
     get "/avaliador/sign_out" => "devise/sessions#destroy",:as => :avaliador_session_out
     get "/avaliador/sign_up" => "avaliadores#new", :as => :novo_avaliador_cadastro
     get "/avaliador/home" => "avaliadores#index", :as => :avaliador_home
     get "/adim/TOTAL_AVALIADORES" => "avaliadores#total_avaliadores", :as => :total_avaliadores
     get "/adim/TOTAL_ALUNOS" => "avaliadores#total_alunos", :as => :total_alunos
     get "/lista-de-avaliacoes/:id" => "avaliadores#exibir_avaliacoes", :as => :lista_de_avaliacoes
     get "/TOTAL_ATIVIDADES" => "avaliadores#total_alunos", :as => :total_atividades
     get "/TOTAL_AVALIACOES" => "avaliadores#listar_avaliacoes", :as => :total_avaliacoes
     get "/admin/geracao_de_relatorio/pdf" => "avaliadores#relatorios_pdf", :as => :admin_relatorio_em_pdf
     match "/localizar-atividades", :controller => "avaliadores", :action=>"localizar_atividade", :as=>:localizar_atividades     
     match "/avaliador/editar_status/:id", :controller => "avaliadores", :action =>"editar_status", :as => :editar_avaliador_status
     match "/avaliador/edit_status/:id/atualizar_status", :controller => "avaliadores", :action =>"atualizar_status", :as => :atualizar_avaliador_status
     match "/avaliador/:id/selecionar_imagem",:controller => "avaliadores", :action=>"selecionar_imagem", :as => :selecionar_imagem_avaliador
     match "/avaliador/:id/salvar_imagem",:controller => "avaliadores", :action=>"load_imagem", :as => :salvar_imagem_avaliador
     match "/avaliador/:id/remover_imagem",:controller => "avaliadores", :action=>"remover_imagem", :as => :remover_imagem_avaliador
     match "/designar-avaliador/atividade/:id/avaliar",:controller => "avaliadores", :action => "avaliar", :as => :designar_atividade
  end

  match "/atividades/:id/delete", :controller => "atividades", :action => "destroy", :as => :excluir_atividade
  resources :pdf_reports, :only => [:pdf_reports, :avaliadores_report, :alunos_report, :atividades_report, :relatorioAtividades_report]

  get "/pdf_reports/menu"
  get "/pdf_reports/avaliadores_report" => "pdf_reports#avaliadores_report", :format => :pdf
  get "/pdf_reports/alunos_report" => "pdf_reports#alunos_report", :format => :pdf
  get "/pdf_reports/atividades_report" => "pdf_reports#atividades_report", :format => :pdf
  get "/pdf_reports/total_de_atividades" => "pdf_reports#relatorioAtividades_report",  :format => :pdf, :as=>:pdf_reports_relatorioAtividades

  authenticated :aluno do
    root :to => "alunos#home"
  end

  authenticated :avaliador do
    root to: "avaliadores#index"
  end

  root :to => "home#index"



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