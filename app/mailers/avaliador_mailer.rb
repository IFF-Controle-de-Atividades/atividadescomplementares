#-*-coding:utf-8-*-

class AvaliadorMailer < ActionMailer::Base
  default :from => "accounts-noreply@iff.edu"

  def novo_avaliador_ativo(admin, avaliador)
	  @admin = admin
	  @avaliador = avaliador
	  
	  @url = "http://www.iff.edu.br/coordinfo/atividadescomplementares/"
	  mail(:to => avaliador.email , :subject => "Você é o novo avaliador",:content_type =>
	       "text/html" )
  end


  def mudanca_de_status(admin, avaliador)
	  @admin = admin
	  @avaliador = avaliador
	  @url = "http://www.iff.edu.br/coordinfo/atividadescomplementares/"
	  mail(
           :to => avaliador.email ,
           :subject => "Seu status como avaliador foi alterado",
           :content_type =>"text/html")
  end


  def informativos(avaliador)
	  @avaliador = avaliador
	  @url = "http://www.iff.edu.br/coordinfo/atividadescomplementares/"
	  mail(:to => avaliador.email , :subject => "Você atualizou seus dados.",:content_type =>
	       "text/html" )
  end
  
end
