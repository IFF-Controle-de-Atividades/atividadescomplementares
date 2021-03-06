#encoding:utf-8
class Atividade
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps
  
  belongs_to :aluno
  has_many :modalidades
  belongs_to :modalidade
  belongs_to :avaliador
  # has_and_belongs_to_many :avaliadores

  field :nome, :type => String
  field :modalidade_nome, :type => String
  field :descricao, :type => String
  field :inicio, :type => Date
  field :termino, :type => Date
  field :carga_horaria, :type => Float
  field :aluno_id, :type => Integer
  field :designada_em, :type => Date
  field :avaliador_id
  field :avaliada, :type => Boolean
  field :carga_horaria_aceita, :type => Integer, :default=>0
  field :justificativa, :type => String
  field :comprovante

  attr_accessible :nome,:modalidade_nome,:descricao,:inicio,:termino,:carga_horaria,:aluno_id,:designada_em,:avaliador_id,:avaliada,:carga_horaria_aceita,:justificativa,:comprovante
  mount_uploader :comprovante, ComprovanteUploader
end
