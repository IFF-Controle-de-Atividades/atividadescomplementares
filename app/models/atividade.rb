#encoding:utf-8
class Atividade
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps
  include Mongoid::Paperclip
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
  field :comprovante_file_name, type: String
  field :comprovante_content_size, type: String
  field :comprovante_file_size, type: Integer
  field :comprovante_updated_at, type: DateTime
  
  validates_presence_of :nome, :message => ' -em branco'

 has_mongoid_attached_file :comprovante,
 :styles =>{:tamanho_pequeno=>["60x50", :png],:tamanho_medio=>["320x240", :png],:tamanho_grande=>["600x600" , :png] },
 :path => ":rails_root/public/anexos/user_files/comprovantes/:class/:attachment/:id/:style_:basename.:extension",
 :url => "/anexos/user_files/comprovantes/:class/:attachment/:id/:style_:basename.:extension",
 :default_url => "samples/iconpdf.png"
 
 validates_attachment_size :comprovante, :less_than => 20.megabytes
 validates_attachment_content_type :comprovante, :content_type => ["image/jpg", "image/jpeg", "image/png", "application/pdf"]
end
