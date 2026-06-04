json.extract! livro, :id, :titulo, :autor, :editora, :isbn, :ano_publicacao, :quantidade_estoque, :created_at, :updated_at
json.url livro_url(livro, format: :json)
