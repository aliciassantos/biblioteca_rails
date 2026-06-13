class Livro < ApplicationRecord
  # Associações
  has_many :emprestimos

  # Validações
  validates :titulo, :autor, :isbn, :quantidade_estoque, presence: true
  validates :quantidade_estoque, numericality: true
  validates :isbn, uniqueness: true

  # BUSCA POR TÍTULO, AUOTR, EDITORA OU ISBN
  def self.search(query)
    if query.present?
      # LOWER garante busca case-insensitive (ignora maiúsculas/minúsculas)
      # % antes e depois garante que filtre quem "contém" o termo buscado
      termo = "%#{query.downcase}%"
      
      where(
        "LOWER(titulo) LIKE :q OR 
         LOWER(autor) LIKE :q OR 
         LOWER(editora) LIKE :q OR 
         LOWER(isbn) LIKE :q", 
        q: termo
      ).order(:titulo)
    else
      order(:titulo) # Mantém ordenado por título caso não haja busca
    end
  end

 # Buscas pré-definidas
  scope :ordenado_por_id, -> { order(id: :asc) }
end