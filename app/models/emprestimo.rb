class Emprestimo < ApplicationRecord
  # Associações
  belongs_to :aluno
  belongs_to :livro

  # Validações
  validates :data_emprestimo, :status, presence: true

  # Busca pre-definidas
  scope :emprestados, -> { where(status: 'Emprestado') }
  scope :devolvidos, -> { where(status: 'Devolvido') }
end
