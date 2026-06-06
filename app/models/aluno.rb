class Aluno < ApplicationRecord
    # Associações
    has_many :emprestimos

    # Validações
    validates :nome_completo, :matricula, :cpf, :data_nascimento, presence: true
    validates :matricula, :cpf, uniqueness: true

    # Calcula a idade do aluno para salvar em CSV
    def calcular_idade
            idade = Date.today.year - data_nascimento.year
            # Verifica se o aniversário já ocorreu este ano
            idade -= 1 if Date.today < data_nascimento.change(year: Date.today.year)
            idade
    end

    # Busca pre-definidas
    scope :ordenados_por_nome, -> { order("nome_completo") }
end
