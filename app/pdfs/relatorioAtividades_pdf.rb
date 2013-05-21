#encoding:utf-8
class AtividadePdf < Prawn::Document
	def initialize(report)
		super(margin_top: 70, left_margin: 17 ,page_layout: :landscape, page_size: "A4" )
		@atividade_report = report
		report_nome
		report_tabela
	end
	
	def report_nome
		text "Relatório de Atividades Complementares", size: 30, style: :bold, horizontal_padding: 30
	end
	
	def report_tabela
		move_down 50
		table items_tabela do
			row(0).font_style = :bold
			columns(1..7).align = :center
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.width = 800
		end
	end
	
	def yes_or_no?(value)
		value ? "Sim" : "Não"
	end
	
	def items_tabela
		[ ["Nome", "Descricao", "Inicio" , "Termino" , "CH" , "Aluno",
"Avaliador"] ] +
			@atividade_report.collect do |item|
			[ item.nome, item.modalidade_nome,
			  item.inicio, item.termino,
			  item.carga_horaria_aceita,
			  if  item.avaliador.nil?
				 item = "Sem Avaliador"
			  else
				item.avaliador.nome
			  end
			]
		end
	end
end
