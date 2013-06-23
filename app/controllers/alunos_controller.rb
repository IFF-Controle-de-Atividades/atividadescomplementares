#encoding:utf-8
class AlunosController < ApplicationController
    private
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")

    before_filter :authenticate_aluno!
    before_filter :current_aluno

    respond_to :html, :xml
    def home
        #TODO generated code can be changed
    end

    def profile_imagem
       #TODO generated code can be changed 
    end
end