#encoding:utf-8
class AlunosController < ApplicationController
    before_filter :authenticate_aluno!
    before_filter :current_aluno
    def home
        #TODO generated code can be changed
    end

    def profile_image
       @aluno = current_aluno
    end

    def change_image
        @aluno = current_aluno
        if @aluno.update_attributes(params[:aluno])
            flash[:notice] = "Sua imagem foi inserida com sucesso"
            redirect_to aluno_home_path
        end
    end

    def remove_image
        @aluno = current_aluno
        @aluno.remove_foto!
        @aluno.remove_foto = true
        if @aluno.save
            flash[:notice] = "Sua imagem foi removida com sucesso"
            redirect_to aluno_home_path
        end
    end  
end