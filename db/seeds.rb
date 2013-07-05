#encoding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
threads = []

def inserir_modalidades
	Modalidade.create(descricao: "Participação em Curso")
	Modalidade.create(descricao: "Ministrante de Curso de Extensão")
	Modalidade.create(descricao: "Atividade de Iniciação Científica")
	Modalidade.create(descricao: "Publicação de Artigo Científico")
	Modalidade.create(descricao: "Publicação de Produção Autoral")
	Modalidade.create(descricao: "Participação em Concurso Acadêmico")
	Modalidade.create(descricao: "Serviço Voluntário")
	Modalidade.create(descricao: "Apresentação de Trabalho Científico")
	Modalidade.create(descricao: "Viagem de Estudo e Visita Técnica")
	Modalidade.create(descricao: "Realização de Curso de Idioma")
	Modalidade.create(descricao: "Participação como Ouvinte em banca de Trabalho de Conclusão")
	Modalidade.create(descricao: "Participação em Comissão Organizadora")
	Modalidade.create(descricao: "Exercício de Cargo Eletivo na Diretoria do DCE")
	Modalidade.create(descricao: "Exercício de Cargo Eletivo na Diretoria do CA do Curso")
	Modalidade.create(descricao: "Participação em Equipe Esportiva do IFF")
	Modalidade.create(descricao: "Certificação Profissional na Área do Curso")
end

def inserindo_administrador
	Avaliador.create(nome: 'Administrador', sexo: 'Masculino', matricula: 'Altere sua matricula', titulacao: 'Alterar sua titulação', email: 'admin@admin.com', password: 'admin', admin: 1, ativo:1)
end	

print "<< Inserindo Modalidades Padronizadas... Dados >>\n\n"
print "<< Você pode inserir mais Modalidades de dentro do Sistema se assim desejar >>"

thr = Thread.new {inserir_modalidades}
thr.join
sleep(5)

print "\n\n<< Inserindo Administrador padrão do Sistema >>\n\n"
print "<< Os dados do administrador podem ser alterados posteriormente >>"

threads << Thread.new {inserindo_administrador}
sleep(5)
threads.each { |thr| thr.join }

print "\n\n<< Fim da excecução. Dados foram inseridos com sucesso >>\n\n"