#encoding:utf-8
class AvaliadoresController < ApplicationController

    before_filter :authenticate_avaliador!
    before_filter :current_avaliador

    respond_to :html, :xml
    def index
    end

    def menu_pdf_report
        #TODO request code change here
    end

    def new
        @avaliador = Avaliador.new
        respond_with @avaliador
    end

    def create
        @avaliador = Avaliador.new(params[:avaliador])
        @admin = current_avaliador
        if @avaliador.save
            AvaliadorMailer.novo_avaliador_ativo(@admin,@avaliador).deliver
            if @avaliador.sexo == 'Masculino'
                flash[:notice]="Avaliador #{@avaliador.nome} foi cadastrado com sucesso."
            elsif @avaliador.sexo == 'Feminino'
                flash[:notice]="Avaliadora #{@avaliador.nome} foi cadastrada com sucesso."
            end
            redirect_to total_avaliadores_path
        else
            render :template=> "avaliadores/new"
        end
    end

    def editar_status
      @avaliador = Avaliador.find(params[:id])
      @admin = current_avaliador
    end

    def atualizar_status
        @avaliador = Avaliador.find(params[:id])
        @admin = current_avaliador
        respond_to do |format|
            if @avaliador.update_attributes(params[:avaliador])
                AvaliadorMailer.mudanca_de_status(@admin,@avaliador).deliver
                format.html { redirect_to total_avaliadores_path}
                flash[:notice] = "Status  - atualizado"
                format.json { head :no_content }
            else
                format.html { render action: "editar_status" }
                format.json { render json: @avaliador.errors,status: :unprocessable_entity }
            end
        end
    end

#     def atividades
#         @x = Aluno.find(params[:id])
#         @atividade_aluno = Atividade.where(:aluno_id => @x ).paginate(:page => params[:page],
#:per_page=>4)

#         @atividade = Atividade.find(params[:id])
#         if @atividade.avaliador_id != current_avaliador.id and current_avaliador.admin == false
#          flash[:alert] = "Nada aqui pra vc"
#          redirect_to :action=> "index"
#         end
#    end


     def localizar_atividade
         @atividade_aluno = Atividade.where(:avalidor_id => current_avaliador.id ).paginate(
         :page => params[:page], :per_page=>5)
     end


    def total_alunos
            @alunos = Aluno.paginate(:page => params[:page], :per_page=>10)
    end
    def total_avaliadores
            @avaliadores = Avaliador.paginate(:page => params[:page], :per_page=>10)
    end
    def listar_atividades
            @atividades = Atividade.paginate(:page => params[:page], :per_page=>4)
    end

    

    #Estes Métodos abaixo são responsaveis por realizar
    #a avaliação das atividades. /atividades/1/edit
#    def avaliar_atividade
#       @atividade_aluno = Atividade.find(params[:id])
#    end

#    def avaliar
#        @atividade_aluno = Atividade.find(params[:id])

#        respond_to do |format|
#            if @atividade_aluno.update_attributes(params[:atividade])
#                if current_avaliador.admin
#                    AtividadeMailer.designar_atividade(@atividade_aluno).deliver
#                        flash[:notice] = "Um avaliador foi designado"
#                else
#                    flash[:notice] = "A Atividade foi avaliada"
#                end
#                format.html { redirect_to :action=> "index" }
#                format.json { head :no_content }
#            else
#                format.html { render action: "avaliar_atividade" }
#                format.json { render json: @atividade_aluno.errors, status: :unprocessable_entity }
#            end
#         end
#     end

    def selecionar_imagem
         @avaliador = Avaliador.find(params[:id ])
    end

    def load_imagem
         @avaliador = Avaliador.find(params[:id ])
         respond_to do |format|
           if @avaliador.update_attributes(params[:avaliador])
               format.html { redirect_to :action=> "index"}
               flash[:notice] = "Sua imagem foi atualizada!"
               format.json { render json: @avaliador, status: :created, location: @avaliador }
           else
               format.html { render action: "index" }
               format.json { render json: @avaliador.errors, status: :unprocessable_entity }
           end
        end
    end

    def remover_imagem
        @avaliador = current_avaliador
        @avaliador.remove_foto!
        @avaliador.remove_foto = true
        if @avaliador.save
            flash[:notice] = "Sua imagem foi removida com sucesso"
            redirect_to avaliador_home_path
        end
    end

#    def listar_avaliacoes
#        if current_avaliador.admin
#            @avaliadores = Avaliador.where(:admin => 0).paginate(:page => params[:page],
#:per_page=>4)
#        else
#            render :action => "index"
#            flash[:alert] = "Acesso restrito"
#        end
#    end


    def exibir_avaliacoes
        if current_avaliador.admin
            @avaliadores = Avaliador.where(:admin => 0).paginate(:page => params[:page],
:per_page=>4)
            @avaliador = Avaliador.find(params[:id])
            @atividades = Atividade.where(:avaliador_id => @avaliador.id).paginate(:page =>

params[:page], :per_page=>4)
            if @atividades.empty?
                redirect_to total_avaliadores_path
                flash[:alert] = "#{@avaliador.nome} Não fez nenhuma avaliação!"
            end
        else
            render :action => "index"
        end
    end

    def relatorios_pdf
    end
end
