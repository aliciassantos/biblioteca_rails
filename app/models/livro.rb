class Livro < ApplicationRecord
    # Associações
    has_many :emprestimos

    # Validações
    validates :titulo, :autor, :isbn, :quantidade_estoque, presence: true
    validates :quantidade_estoque, numericality: true
    validates :isbn, uniqueness: true

    # Busca pre-definidas
    scope :disponiveis, -> { where("quantidade_estoque > 0") }
end
