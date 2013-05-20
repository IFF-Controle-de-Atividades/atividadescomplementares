#encoding:utf-8
class Modalidade
  include Mongoid::Document
  field :descricao, type: String
  attr_accessible :descricao
end
