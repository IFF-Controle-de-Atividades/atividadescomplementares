#encoding:utf-8
class AvaliadorPdf < Prawn::Document
    def initialize(report)
        super(margin_top: 70, left_margin: 30 ,page_layout: :landscape, page_size: "A4" )
        @avaliador_report = report
        image "#{Rails.root}/app/assets/images/IFFbanner.png", width: 690
#        stroke_bounds
        move_down 20
        report_nome
        report_tabela
    end

    def report_nome
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")
        text "Lista de Avaliadores cadastrados - #{data_do_dia}", size: 24, style: :bold
    end

    def linha_de_assinatura
        stroke do
            horizontal_line 200, 500, :at => 10
        end
    end

    def report_tabela
        move_down 20
        table items_tabela do
            row(0).font_style = :bold
            columns(1..4).align = :center
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.width = 777
        end
        linha_de_assinatura
        draw_text "Assinatura do Coordenador", :at => [280,0.5]
    end

    def yes_or_no?(value)
        value ? "Sim" : "Não"
    end

    def status?(value)
        value ? "Ativo" : "Não ativo"
    end

    def items_tabela
        [ ["Nome", "Titulação","Matricula", "Ativo" ,"Email de Contato", "Administrador"] ] +
            @avaliador_report.collect do |item|
         [item.nome, item.titulacao, item.matricula, status?(item.ativo),
         item.email,yes_or_no?(item.admin)]
        end
    end
end
