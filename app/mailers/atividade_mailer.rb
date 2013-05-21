class AtividadeMailer < ActionMailer::Base
  default :from => "accounts-noreply@iff.edu"
  
  def atividade_registration(aluno, atividade)
    @aluno_atual = aluno
    @atividade = atividade
    #email_with_name = "#{@aluno_atual.nome} < #{@aluno_atual.email}"
    @url = "http://www.iff.edu.br/coordinfo/atividadescomplementares/"
    mail(:to => aluno.email , :subject => "Atividade Inserida",:content_type => "text/html" )
  end

  def designar_atividade(atividade, avaliador)
    @atividade = atividade
    @url = "http://www.iff.edu.br/coordinfo/atividadescomplementares/"
    mail(:to => avaliador , :subject => " Atividade a ser Avaliada",:content_type => "text/html" )
  end
end
