class Emprestimo < ApplicationRecord
  # Permissão para receber os dados do formulário
  attr_accessor :matricula_aluno, :isbn_livro

  after_initialize :definir_status_padrao, if: :new_record?

  # Validações
  validates :data_emprestimo, :status, presence: true
  validates :data_devolucao, presence: true

  # Métodos próprios para validar dados
  validate :data_devolucao_nao_pode_ser_no_passado
  validate :verificar_se_tem_matricula
  validate :verificar_estoque

  # Verifica se a data de devolução já expirou
  def devolucao_vencida?
    if data_devolucao.present? && data_devolucao < Date.today  && status == "Emprestado"
      true
    else
      false
    end
  end

  private

  # Verifica se a data de devolução foi preenchida corretamente
  def data_devolucao_nao_pode_ser_no_passado
    if data_devolucao.present? && data_emprestimo.present? && data_devolucao < data_emprestimo
      errors.add(:data_devolucao, "não pode ser anterior à data de empréstimo")
    end
  end

  # Prossegue com o empréstimo caso a matrícula exista
  def verificar_se_tem_matricula
    aluno = Aluno.find_by(matricula: matricula_aluno)

    if aluno.present?
      self.aluno = aluno
    else
      errors.add(:matricula_aluno, "não encontrada")
    end
  end

  # Só realiza o empréstimo caso haja quantidade suficiente de livros
  def verificar_estoque
      livro = Livro.find_by(isbn: isbn_livro)
      if livro.present? && livro.quantidade_estoque >= 1
        self.livro = livro
        livro.quantidade_estoque -= 1
        # atualiza o estoque no banco
        livro.save
      else
        errors.add(:isbn_livro, "Quantidade insuficiente no estoque: ")
      end
  end

  def definir_status_padrao
        self.status ||= "Emprestado"
  end

  # Busca pre-definidas
  scope :emprestados, -> { where(status: "Emprestado") }
  scope :devolvidos, -> { where(status: "Devolvido") }

  # Associações
  belongs_to :aluno
  belongs_to :livro
end
