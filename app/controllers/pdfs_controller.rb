#encoding:utf-8
require 'prawn/layout'
class PdfsController < ApplicationController
	private 
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")	

  	def aluno_atividades_pdf
  	end

  	def avaliadores_pdf
  	end

  	def atividades_pdf
  	end

  	def alunos_pdf
  	end
end
