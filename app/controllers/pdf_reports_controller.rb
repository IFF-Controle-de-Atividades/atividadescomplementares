#encoding:utf-8
require 'prawn/layout'
class PdfReportsController < ApplicationController
    #private 
    #    time = Time.now
    #    data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")


    def menu
    end

    def avaliadores_report
        @avaliadores = Avaliador.all
        respond_to do |formato|
            formato.html
            formato.pdf do
                pdf = AvaliadorPdf.new(@avaliadores)
                send_data pdf.render, filename: "Listagem_Avaliadores.pdf",
                type: "application/pdf", disposition: "inline"
            end
        end
    end


    def alunos_report
        @alunos = Aluno.all
        respond_to do |formato|
            formato.html
            formato.pdf do
                pdf = AlunoPdf.new(@alunos)
                send_data pdf.render, filename: "Listagem_Alunos.pdf",
                type: "application/pdf", disposition: "inline"
            end
        end
    end

    def atividades_report
        @atividades = Atividade.all
        respond_to do |formato|
            formato.html
            formato.pdf do
               #render :layout => false
               pdf = AtividadePdf.new(@atividades, view_context)
               send_data pdf.render, filename: "Atividades.pdf",
               type: "application/pdf", disposition: "inline"
            end
        end
    end

    def relatorioAtividades_report
        @atividades = Atividade.where(:aluno_id => current_aluno)
        respond_to do |formato|
            formato.html
            formato.pdf do
               #render :layout => false
               pdf = AtividadesDoAlunoPdf.new(@atividades)
               send_data pdf.render, filename: "Atividades.pdf",
               type: "application/pdf", disposition: "inline"
            end
        end
    end 
end
