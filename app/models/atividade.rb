#encoding:utf-8
class Atividade
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps
  
  
  belongs_to :aluno
  has_many :modalidades
  belongs_to :modalidade
  belongs_to :avaliador

  field :nome, type: String
  field :modalidade_nome, type: String
  field :inicio, type: Date
  field :termino, type: Date
  field :carga_horaria, type: Float
  field :aluno_id, type: Integer
  field :designada_em, type: Date
  field :avaliador_id, type: Integer
  field :avaliada, type: Boolean
  field :carga_horaria_aceita, type: Integer
  field :justificativa, type: String
  
  mount_uploader :comprovante, ComprovanteUploader
end
