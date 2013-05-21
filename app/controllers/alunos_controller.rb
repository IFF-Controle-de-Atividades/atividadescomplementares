#encoding:utf-8
class AlunosController < ApplicationController
	
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
        respond_to do |format|
            if @aluno.update_attributes(params[:aluno])
                format.html { redirect_to aluno_home_path}
                flash[:notice] = "Sua imagem foi atualizada!"
                format.json { render json: @aluno, status: :created, location: @aluno }
            else
                format.html { render action: "home" }
                format.json { render json: @aluno.errors, status: :unprocessable_entity }
            end
        end
    end    
    
    def remover_imagem
        @aluno = Aluno.find(params[:id ])
        respond_to do |format|
            if @aluno.update_attributes(:photo => nil)
                format.html { redirect_to aluno_home_path}
                flash[:notice] = "Sua imagem foi removida!"
                format.json { render json: @aluno, status: :created, location: @aluno }
            else
                format.html { render action: "home" }
                format.json { render json: @aluno.errors, status: :unprocessable_entity }
            end
        end
    end
    
   
    def atividades
	end
end
