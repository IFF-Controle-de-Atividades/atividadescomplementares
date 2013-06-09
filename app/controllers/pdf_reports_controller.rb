#encoding:utf-8
require 'prawn/layout'
class PdfReportsController < ApplicationController
    private 
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")

    def aluno_atividades_report
        @aluno = current_aluno
        @atividades = Atividade.where(aluno_id: @aluno)
        respond_to do |paper|
            paper.html
            paper.pdf do
               #render :layout => false
               pdf = AtividadePdf.new(@atividades, view_context)
               send_data pdf.render, filename: "Minhas_Atividades.pdf",
               type: "application/pdf", disposition: "inline"
            end
        end
    end    
end
