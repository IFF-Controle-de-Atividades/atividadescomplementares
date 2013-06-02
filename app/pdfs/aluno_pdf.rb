#encoding:utf-8
class AlunoPdf < Prawn::Document
    PDF_OPTIONS =
    {
        :page_size   => "A4",
        :page_layout => :landscape,
        :margin      => [10, 17]
    }

    def initialize(report)
        super(PDF_OPTIONS)
        @aluno_report = report
        image "#{Rails.root}/app/assets/images/IFFbanner.png", width: 690
        __PDF__
    end

    def __PDF__
        move_down 20
        report_nome
        if @aluno_report.empty?
            draw_text "Não há alunos cadastrados", :at => [230,255], :size=> 20
            draw_text "_" * 46, :at => [220,255]
            draw_text "Por-favor aguarde alunos", :at => [236,225], :size=> 20
            draw_text "_" * 46, :at => [220,225]
            draw_text "Att: A Coordenação", :at => [600,25], :size=> 20
            draw_text "_" * 26, :at => [600,18]
        else
            report_tabela
            move_down 50
        end
    end

    def report_nome
        time = Time.now
        data_do_dia = time.strftime("%d/%m/%Y - %H:%M:%S")
        text "Lista de Alunos - Cadastrados", size: 25, style: :bold, horizontal_padding: 30
        text "#{data_do_dia}", size: 19, style: :bold
    end

    def linha_de_assinatura
        stroke do
            horizontal_line 200, 500, :at => 10
        end
    end

    def report_tabela
        move_down 30
        table items_tabela do
            row(0).font_style = :bold
            columns(1..7).align = :center
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.width = 800
            self.header = true
        end
        linha_de_assinatura
        draw_text "Assinatura do Coordenador", :at => [280,0.5]
    end

    def yes_or_no?(value)
        value ? "Sim" : "Não"
    end

    def items_tabela
        [ ["Nome", "Idade", "Sexo" , "Curso" , "Periodo" , "Matricula", "Email de Contato"] ] +
            @aluno_report.collect do |item|
            [ item.nome, item.idade,
              item.sexo, item.curso,
              item.periodo, item.matricula,
              item.email
            ]
        end
    end
end