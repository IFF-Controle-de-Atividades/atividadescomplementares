#encoding:utf-8
class AvaliacoesController < ApplicationController
    before_filter :authenticate_avaliador!
    before_filter :current_avaliador

   respond_to :html, :xml
   def listar_atividades_complementares
        if not current_avaliador.admin
            flash[:alert] = "Acesso restrito"
            redirect_to avaliador_home_path  
        else
            @atividades = Atividade.paginate(:page => params[:page], :per_page=>4)
            @avaliadores= Avaliador.all
        end

        if Atividade.empty?
            flash[:alert] = "Não foram encontradas Atividades."
            redirect_to avaliador_home_path
        end
    end

    def designar
        Atividade.where(:id => params[:atividades_ids]).update_all(:designada_em => Time.now, :avaliador_id => params[:avaliador_id])
        @atividade = Atividade.where(:id => :atividades_ids)
        #@avaliador = Avaliador.where(:id => :avaliador_id)
#        @avaliador = Avaliador.find_by_sql("SELECT email FROM avaliadores WHERE id= #{params[:avaliador_id]};")
       
#        AtividadeMailer.designar_atividade(@atividade, @avaliador).deliver
       
        flash[:notice] = "Um avaliador foi designado"
        redirect_to :action=> "listar_atividades_complementares"
    end

    def list
        @aluno = Aluno.find(params[:id])
        @avaliadores= Avaliador.all
        @atividade_aluno = Atividade.where(:aluno_id => @aluno.id ).paginate(:page => params[:page], :per_page=>4)
    end

    def x_list
        @aluno = Aluno.find(params[:id])
        @atividade_aluno = Atividade.where(:aluno_id => @aluno.id ).paginate(:page => params[:page], :per_page=>4)
    end


    #Estes Métodos abaixo são responsaveis por realizar
    #a avaliação das atividades.
    #/atividades/1/edit
    def avaliar_atividade
       @atividade_aluno = Atividade.find(params[:id])
    end

    def avaliar
        @atividade_aluno = Atividade.find(params[:id])

        respond_to do |format|
            if @atividade_aluno.update_attributes(params[:atividade])
                if current_avaliador.admin
                    AtividadeMailer.designar_atividade(@atividade_aluno).deliver
                        flash[:notice] = "Um avaliador foi designado"
                else
                    flash[:notice] = "A Atividade foi avaliada"
                end
                format.html { redirect_to x_list_path(@atividade_aluno.aluno_id) }
                format.json { head :no_content }
            else
                format.html { render action: "avaliar_atividade" }
                format.json { render json: @atividade_aluno.errors, status: :unprocessable_entity }
            end
         end
     end

     def listar_avaliacoes
        if current_avaliador.admin
            @avaliadores = Avaliador.where(:admin => 0).paginate(:page => params[:page],
:per_page=>4)
        else
            redirect_to avaliador_home_path
            flash[:alert] = "Acesso restrito"
        end
    end
   
    #Exibe avaliacoes feitas por um determinado avaliador
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
            redirect_to avaliador_home_path
        end
    end
   
end
