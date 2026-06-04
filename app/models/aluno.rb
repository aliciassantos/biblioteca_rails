class Aluno < ApplicationRecord
    # Associações
    has_many :emprestimos

    # Validações
    validates :nome_completo, :matricula, :cpf, :data_nascimento, presence: true
    validates :matricula, :cpf, uniqueness: true
  
    # Busca pre-definidas
    scope :ordenados_por_nome, -> { order('nome_completo') }
end
