#encoding:utf-8
class PdfReportsController < ApplicationController
	def atividadealuno
	    @aluno = current_aluno
	    respond_to do |format|
	    	format.html
	    	format.pdf do
	    		#render :layout => false
               pdf = AtividadesPdf.new(@aluno)
               send_data pdf.render, filename: "Listagem_Atividades.pdf",
               type: "application/pdf", disposition: "inline"
	    	end
	    end
    end
end
