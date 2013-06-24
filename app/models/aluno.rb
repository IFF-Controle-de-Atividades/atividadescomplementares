#encoding:utf-8
class Aluno
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps

  field :nome, :type => String
  field :idade, :type => Integer
  field :sexo, :type => String
  field :endereco , :type => String
  field :matricula, :type => String
  field :curso, :type => String
  field :periodo, :type => String
  field :foto
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  
  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  #VALIDAÇÕES E PARAMETROS ACESSIVEIS

  attr_accessible :nome, :idade, :sexo,:endereco, :curso,:periodo,:matricula,:email, :password, :password_confirmation, :remember_me, :foto
  mount_uploader :foto, ImagemUploader
  has_many :atividades
  
  validates_presence_of :nome, :message=>" - Deve ser preenchido."
  validates_presence_of :idade,:message => " - Deve ser preenchido."
  validates_presence_of :endereco, :message=> " - Deve ser preenchido."
  validates_presence_of :curso, :message=> " - Deve ser preenchido."
  validates_presence_of :matricula,:message=>" - Deve ser preenchido."
 
  validates_length_of   :nome, :maximum=> 50, :message=> " - Deve conter menos de 50 caracteres"
  validates_length_of   :endereco, :maximum=>80,:message=>" - Deve conter  menos de 80 caracteres"
  validates_length_of   :matricula,:maximum=>20,:message=>" - Deve conter no máximo de 20 caracteres."
 
  validates_uniqueness_of :nome,:message=>" - Já se encontra em uso. Por favor escolha outro!"
  validates_uniqueness_of :matricula, :message=>" - Já se encontra em uso."
  validates_uniqueness_of :email, :message=>" Já se encontra em uso."

  def contar_horas_enviadas(aluno_atual)
    aluno = aluno_atual  
    total_horas = Atividade.where(:aluno_id => aluno)
    total_horas = total_horas.sum(:carga_horaria)
    if total_horas >= 360 
         return "Horas cumpridas = #{$total_horas} - Você possui horas suficientes!"
     else 
         return "Horas cumpridas= #{$total_horas} - Você não possui horas o suficiente! "
     end    
  end

  def contar_horas_aceitas(aluno_atual)
    aluno = aluno_atual
    total_horas = Atividade.where(:aluno_id => aluno)
    total_horas = total_horas.sum(:carga_horaria_aceita)
    if total_horas >= 360
       return "Total de Horas = #{total_horas} - Você possui horas suficientes!"
    else
       return "Total de Horas= #{total_horas} - Você não possui horas o suficiente! "
    end
  end
  
  scope :buscar_pelo_nome, lambda{|nome| where(:nome => nome)} 
end