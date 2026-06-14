class Aluno < ApplicationRecord
  # Associações
  has_many :emprestimos, dependent: :destroy

  # Validações
  validates :nome_completo, :cpf, :data_nascimento, presence: true
  validates :cpf, uniqueness: true

  # Expressão Regular para validar o formato padrão de e-mails
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Validação do E-mail
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX, message: "não é um e-mail válido" }

  # BUSCAR POR ID, NOME, CPF OU EMAIL
  def self.search(query)
    if query.present?
      termo = "%#{query.downcase}%"
      # Ajustado de CHAR para VARCHAR(255) para garantir compatibilidade universal entre bancos
      where(
        "CAST(id AS CHAR(10)) LIKE :q OR
         LOWER(nome_completo) LIKE :q OR
         LOWER(cpf) LIKE :q OR
         LOWER(email) LIKE :q",
        q: termo
      ).ordenados_por_id
    else
      ordenados_por_id
    end
  end

  # Calcula a idade do aluno para salvar em CSV/PDF
  def calcular_idade
    idade = Date.today.year - data_nascimento.year
    idade -= 1 if Date.today < data_nascimento.change(year: Date.today.year)
    idade
  end

  # Buscas pré-definidas
  scope :ordenados_por_nome, -> { order(:nome_completo) }
  scope :ordenados_por_id,   -> { order(id: :asc) }
end
