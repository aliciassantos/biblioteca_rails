class Emprestimo < ApplicationRecord
  belongs_to :aluno, optional: true
  belongs_to :livro, optional: true

  # Define explicitamente a chave composta da tabela de relacionamento
  self.primary_key = [:aluno_id, :livro_id]

  # Atributos virtuais
  attr_accessor :aluno_id_input, :isbn_livro

  # Gatilhos do ciclo de vida
  after_initialize :definir_status_padrao, if: :new_record?
  before_create :dar_baixa_no_estoque_ao_criar 
  before_save :atualizar_status_por_atraso
  before_save :atualizar_estoque_na_devolucao, if: :status_changed?

  # Validações Padrão
  validates :data_emprestimo, :status, presence: true
  validates :data_devolucao, presence: true

  # Métodos de validação customizados
  validate :data_devolucao_nao_pode_ser_no_passado, on: :create
  validate :verificar_se_tem_aluno, on: :create
  validate :verificar_estoque, on: :create

  # BUSCA 
  def self.search(query)
    if query.present?
      termo = "%#{query.downcase}%"
      
      left_outer_joins(:aluno, :livro).where(
        "CAST(emprestimos.aluno_id AS CHAR) LIKE :q OR 
         CAST(emprestimos.livro_id AS CHAR) LIKE :q OR 
         LOWER(alunos.nome_completo) LIKE :q OR 
         LOWER(livros.titulo) LIKE :q OR 
         LOWER(emprestimos.status) LIKE :q", 
        q: termo
      ).order(data_emprestimo: :desc)
    else
      order(data_emprestimo: :desc)
    end
  end

  # Buscas pré-definidas
  scope :emprestados, -> { where(status: "Emprestado") }
  scope :devolvidos, -> { where(status: "Devolvido") }
  scope :em_atraso, -> { where(status: "Em atraso") }

  # Verifica se a data de devolução já expirou
  def devolucao_vencida?
    data_devolucao.present? && data_devolucao < Date.today && status == "Emprestado"
  end

  private

  # Garante que o status no banco mude para "Em atraso" se necessário
  def atualizar_status_por_atraso
    if status == "Emprestado" && devolucao_vencida?
      self.status = "Em atraso"
    end
  end

  # Verifica se a data de devolução foi preenchida corretamente
  def data_devolucao_nao_pode_ser_no_passado
    if data_devolucao.present? && data_emprestimo.present? && data_devolucao < data_emprestimo
      errors.add(:data_devolucao, "não pode ser anterior à data de empréstimo")
    end
  end

  # Prossegue com o empréstimo caso o ID do Aluno exista
  def verificar_se_tem_aluno
    aluno_encontrado = Aluno.find_by(id: aluno_id_input)

    if aluno_encontrado.present?
      self.aluno = aluno_encontrado
    else
      errors.add(:aluno_id_input, "não encontrado no sistema")
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