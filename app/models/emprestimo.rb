class Emprestimo < ApplicationRecord
  # Associações
  belongs_to :aluno
  belongs_to :livro

  # Validações
  validates :data_emprestimo, :status, presence: true
  validates :data_devolucao, presence: true

  # Método próprio para verificar a data de devolução
  validate :data_devolucao_nao_pode_ser_no_passado

  #Verifica se a data de devolução já expirou
  def devolucao_vencida? 
    if data_devolucao.present? && data_devolucao < Date.today  && status == 'Emprestado' 
      true
    else
      false
    end
  end

  private

  #Verifica se a data de devolução foi preenchida corretamente
  def data_devolucao_nao_pode_ser_no_passado
    if data_devolucao.present? && data_emprestimo.present? && data_devolucao < data_emprestimo
      errors.add(:data_devolucao, "não pode ser anterior à data de empréstimo")
    end
  end

  # Busca pre-definidas
  scope :emprestados, -> { where(status: 'Emprestado') }
  scope :devolvidos, -> { where(status: 'Devolvido') }
end
