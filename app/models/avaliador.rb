#encoding:utf-8
class Avaliador
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps
  #include Mongoid::Paperclip

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  field :nome, type: String
  field :sexo, type: String
  field :matricula, type: String
  field :titulacao, type: String

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  attr_accessible :nome, :matricula , :sexo,
                  :titulacao, :email, :password, 
                  :password_confirmation, :remember_me, 
                  :admin, :ativo

  has_many :atividades

  validates_presence_of :nome, :message=>" - Deve ser preenchido."
  validates_presence_of :sexo,:message => " - Deve ser preenchido."
  validates_presence_of :titulacao, :message=> " - Deve ser preenchido."
  validates_presence_of :matricula,:message=>" - Deve ser preenchido."

  validates_length_of   :nome, :maximum=> 50, :message=> " - Deve conter no máximo 50 caracteres"
  validates_length_of   :titulacao, :maximum=>80,:message=>" - Deve conter máximo 80 caracteres"
  validates_length_of   :matricula,:maximum=>12,:message=>" - Deve conter no máximo de 12 caracteres."

  validates_uniqueness_of :nome,:message=>" - Já se encontra em uso."
  validates_uniqueness_of :email, :message=>" Já se encontra em uso."
  validates_uniqueness_of :matricula, :message=>" Já se encontra em uso."
end
