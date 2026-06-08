class Emprestimo < ApplicationRecord
  belongs_to :aluno, optional: true
  belongs_to :livro, optional: true

  # Permissão para receber os dados virtuais do formulário
  attr_accessor :matricula_aluno, :isbn_livro

  # Gatilhos do ciclo de vida
  after_initialize :definir_status_padrao, if: :new_record?
  before_create :dar_baixa_no_estoque_ao_criar # Garante que só altera o estoque se passar em todas as validações!
  before_save :atualizar_estoque_na_devolucao, if: :status_changed?

  # Validações Padrão
  validates :data_emprestimo, :status, presence: true
  validates :data_devolucao, presence: true

  # Métodos de validação customizados
  validate :data_devolucao_nao_pode_ser_no_passado, on: :create
  validate :verificar_se_tem_matricula, on: :create
  validate :verificar_estoque, on: :create

  # Busca pré-definidas
  scope :emprestados, -> { where(status: "Emprestado") }
  scope :devolvidos, -> { where(status: "Devolvido") }

  # Verifica se a data de devolução já expirou
  def devolucao_vencida?
    data_devolucao.present? && data_devolucao < Date.today && status == "Emprestado"
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
    aluno_encontrado = Aluno.find_by(matricula: matricula_aluno)

    if aluno_encontrado.present?
      self.aluno = aluno_encontrado
    else
      errors.add(:matricula_aluno, "não encontrada")
    end
  end

  # Apenas checa se o livro existe e tem estoque
  def verificar_estoque
    livro_encontrado = Livro.find_by(isbn: isbn_livro)

    if livro_encontrado.present?
      if livro_encontrado.quantidade_estoque >= 1
        self.livro = livro_encontrado
      else
        errors.add(:isbn_livro, "Quantidade insuficiente no estoque")
      end
    else
      errors.add(:isbn_livro, "Livro não encontrado com o ISBN informado")
    end
  end

  # Só altera o estoque do livro se o formulário inteiro for válido e for salvar de verdade
  def dar_baixa_no_estoque_ao_criar
    if livro.present?
      livro.quantidade_estoque -= 1
      livro.save
    end
  end

  def definir_status_padrao
    self.status ||= "Emprestado"
  end

  # Devolve o livro para a prateleira quando o status mudar para "Devolvido"
  def atualizar_estoque_na_devolucao
    if status == "Devolvido" && livro.present?
      livro.quantidade_estoque += 1
      livro.save
    end
  end
end
