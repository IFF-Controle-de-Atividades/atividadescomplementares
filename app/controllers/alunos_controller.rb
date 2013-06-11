#encoding:utf-8
class AlunosController < ApplicationController
    private 
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")  
	
    before_filter :authenticate_aluno!
	before_filter :current_aluno
	
    respond_to :html, :xml
	def home
	end
	
    def selecionar_imagem
        @aluno = Aluno.find(params[:id ])
    end    
    
    def load_imagem
        @aluno = Aluno.find(params[:id ])
        flash[:notice] = "Sua imagem foi inserida com sucesso"
        redirect_to aluno_home_path
    end    
    
    def remover_imagem
        @aluno = Aluno.find(params[:id ])
        respond_to do |format|
            if @aluno.update_attributes(:foto => nil)
                flash[:notice] = "Sua imagem foi removida para colocar novamente insira outra"
                format.html { redirect_to aluno_home_path }
            end
        end
    end
   
    def atividades
	end

    
end
