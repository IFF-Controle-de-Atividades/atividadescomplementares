#encoding:utf-8
Atividadescomplementares::Application.routes.draw do

  resources :widgets, only: [:index]
  resources :pdf_reports, only: [:atividadealuno, :alunos_pdf, :avaliadores_pdf, :total_atividades]


  resources :alunos,:only => [:home, :profile_image, :change_image, :remove_image, :password,:change_password]
  
  resources :avaliadores, :only => [:index, :new,:create,:editar_status,:atualizar_status,:localizar_atividade,:total_alunos,:total_avaliadores,:total_atividades,:selecionar_imagem,:load_imagem,:remover_imagem,:exibir_avaliacoes,:relatorios_pdf]
  
  resources :atividades
  
  resources :avaliacoes,
            :only =>[
                     :listar_atividades_complementares,
                     :avaliar_atividade,
                     :avaliar,
                     :listar_avaliacoes,
                     :exibir_avaliacoes
                    ],
            :collection => { :designar => :put }

  devise_for :alunos, :skip => [:sessions]
  
  devise_for :avaliadores, :skip => [:sessions]

  as :avaliacoes do
      put "avaliacoes/designar", :as=> :designar
      get "avaliacoes/listar_atividades_complementares" => "avaliacoes#listar_atividades_complementares", :as => :atividades_complementares
      get "avaliacoes/listar_avaliacoes"
      get "avaliacoes/exibir_avaliacoes/:id"=> "avaliacoes#exibir_avaliacoes", :as => :exibir_avaliacoes_complementares
      match "/lista-de-atividades/:id", :controller =>"avaliacoes", :action=>"list", :as=> :listagem_de_atividades_do_aluno_x
      match "/atividades_de/:nome/:id", :controller => "avaliacoes", :action=>"x_list", :as=> :listagemdeatividadesdoaluno
      get "/avaliar_atividades/:id",:controller => "avaliacoes", :action=>"x_list", :as=>:x_list
      match "/avaliar_atividade/:id/", :controller => "avaliacoes", :action=>"avaliar_atividade", :as => :avaliar_atividade
      match "/avaliar_atividade/:id/avaliar", :controller => "avaliacoes", :action=>"avaliar", :as => :update_avaliar_atividade
  end

  as :aluno do
     get "/aluno/sign_in" => "devise/sessions#new", :as => :new_aluno_session
     post "/aluno/sign_in" => "devise/sessions#create", :as => :aluno_session
     get "/aluno/sign_out" => "devise/sessions#destroy", :as => :aluno_session_out
     get "/aluno/home/" => "alunos#home", :as => :aluno_home
     get "/listadeatividades" => "alunos#atividades", :as => :listadeatividades
     get "/imagemdoperfil"  => "alunos#profile_image", :as => :profile_image
     get "/imagemdoperfilpadrao"=> "alunos#remove_image", :as => :default_image
     get "/alterarsenha/:id"=> "alunos#password", :as => :password
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
     get "/TOTAL_ATIVIDADES" => "avaliadores#total_alunos", :as => :aluno_atividades
     get "/TOTAL_AVALIACOES" => "avaliadores#listar_avaliacoes", :as => :total_avaliacoes
     get "/admin/geracao_de_relatorio/pdf" => "avaliadores#relatorios_pdf", :as => :admin_relatorio_em_pdf
     match "/localizar-atividades", :controller => "avaliadores", :action=>"localizar_atividade", :as=>:localizar_atividades
     match "/avaliador/editar_status/:id", :controller => "avaliadores", :action =>"editar_status", :as => :editar_avaliador_status
     match "/avaliador/edit_status/:id/atualizar_status", :controller => "avaliadores", :action =>"atualizar_status", :as => :atualizar_avaliador_status
     match "/avaliador/:id/selecionar_imagem",:controller => "avaliadores", :action=>"selecionar_imagem", :as => :selecionar_imagem_avaliador
     match "/avaliador/:id/salvar_imagem",:controller => "avaliadores", :action=>"load_imagem", :as => :salvar_imagem_avaliador
     match "/avaliador/:id/remover_imagem",:controller => "avaliadores", :action=>"remover_imagem", :as => :remover_imagem_avaliador
  end

  match "/atividades/:id/delete", :controller => "atividades", :action => "destroy", :as => :excluir_atividade

  get "/minhas-atividades" => "pdf_reports#atividadealuno", :format=> :pdf, :as=>:alunoatividades
  get "/total-avaliadores" => "pdf_reports#avaliadores_pdf", :format => :pdf, :as=> :avaliadores_pdf
  get "/total-alunos" => "pdf_reports#alunos_pdf", :format => :pdf, :as=> :alunos_pdf
  get "/total-atividades" => "pdf_reports#total_atividades", :format => :pdf, :as=> :total_atividades

  authenticated :aluno do
    root :to => "alunos#home"
  end

  authenticated :avaliador do
    root to: "avaliadores#index"
  end

  root :to => "home#index"
  match "/upload/grid/*path" => "gridfs#serve"

  match ":controller(/:action(/:id))(.:format)"
end