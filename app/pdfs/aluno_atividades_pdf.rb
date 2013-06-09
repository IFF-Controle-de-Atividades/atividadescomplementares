#encoding:utf-8
class Aluno_AtividadePdf < Prawn::Document
    PDF_OPTIONS =
    {
        :page_size => "A4",
        :page_layout => :landscape,
        :margin => [10, 17]
    }
    def initialize(report)
        super(PDF_OPTIONS )
        @aluno_atividade = report
        image "#{Rails.root}/app/assets/images/IFFbanner.png", width: 690
        __PDF__
    end

    def __PDF__
        move_down 50
        report_nome
        if @aluno_atividade.empty?
            draw_text "Você não possui atividades", :at => [230,255], :size=> 20
            draw_text " _" * 26, :at => [220,255]
            draw_text "Por-favor insira atividades", :at => [236,225], :size=> 20
            draw_text " _" * 26, :at => [220,225]
            draw_text "Att: A Coordenação", :at => [600,25], :size=> 20
            draw_text "_" * 26, :at => [600,18]
        else
            report_tabela
            move_down 100
            linha_de_assinatura
            draw_text "Assinatura do Coordenador", :at => [280,0.5]
        end
    end

    def nova_pagina
        start_new_page
        linha_de_assinatura
    end

    def linha_de_assinatura
        stroke do
            move_down 5
            horizontal_line 200, 500, :at => 10
        end
    end

    def report_nome
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")
        text "Relatório de Atividades Complementares", size: 20, style: :bold, horizontal_padding: 30
        text "\n#{data_do_dia}", size: 15, style: :bold
    end

    def report_tabela
        move_down 20
        table(items_tabela) do
            self.row(0).font_style = :bold
            self.columns(1..4).align = :center
            self.columns(2..4).width = 90
            self.cells.padding = 13
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.width = 805
            self.header = true
        end
        move_down 20
    end

    def yes_or_no?(value)
        value ? "Sim" : "Não"
    end

    def items_tabela
        [ ["Nome", "Descricao", "Inicio" , "Termino" , "CH" , "Aluno",
            "Avaliador"] ] +
            @aluno_atividade.collect do |item|
                [ item.nome, item.modalidade_nome,
                    item.inicio.strftime("%d/%m/%y"),
                    item.termino.strftime("%d/%m/%y"),
                    item.carga_horaria_aceita,
                    item.aluno.nome,
                    if item.avaliador.nil?
                        item = "Sem Avaliador"
                    else
                        item.avaliador.nome
                    end
                ]
            end
    end
end