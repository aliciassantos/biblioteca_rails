# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Limpando o banco'
Emprestimo.destroy_all
Aluno.destroy_all
Livro.destroy_all

# ALIMENTANDO O BANCO COM DADOS FICTÍCIOS PARA TESTES
# As exclamações servem para que o banco mostre o erro de algum dado inválido
# perante as validações das tabelas

puts 'Criando alunos...'
a1 = Aluno.create!(nome_completo: "Alice Silva", cpf: "111.001.212-21", data_nascimento: "1999-11-30", email: "alice@email.com", telefone: "(86) 99999-1111")
a2 = Aluno.create!(nome_completo: "Bruno Costa", cpf: "111.002.028-22", data_nascimento: "2000-05-12", email: "bruno@email.com", telefone: "(86) 99999-2222")
a3 = Aluno.create!(nome_completo: "Carla Dias", cpf: "111.003.222-90", data_nascimento: "2001-08-20", email: "carla@email.com", telefone: "(86) 99999-3333")
a4 = Aluno.create!(nome_completo: "Diego Farias", cpf: "111.004.111-78", data_nascimento: "1998-02-15", email: "diego@email.com", telefone: "(86) 99999-4444")
a5 = Aluno.create!(nome_completo: "Elisa Gomes", cpf: "111.005.211-22", data_nascimento: "2002-10-10", email: "elisa@email.com", telefone: "(86) 99999-5555")
a6 = Aluno.create!(nome_completo: "Fabio Lima", cpf: "111.006.696-68", data_nascimento: "1997-04-22", email: "fabio@email.com", telefone: "(86) 99999-6666")
a7 = Aluno.create!(nome_completo: "Gabriela Rosa", cpf: "111.007.090-22", data_nascimento: "2000-09-09", email: "gabriela@email.com", telefone: "(86) 99999-7777")
a8 = Aluno.create!(nome_completo: "Hugo Souza", cpf: "111.008.999-99", data_nascimento: "1999-01-30", email: "hugo@email.com", telefone: "(86) 99999-8888")
a9 = Aluno.create!(nome_completo: "Isabel Lima", cpf: "111.009.292-22", data_nascimento: "2003-03-14", email: "isabel@email.com", telefone: "(86) 99999-9999")
a10 = Aluno.create!(nome_completo: "João Pereira", cpf: "111.010.562-20", data_nascimento: "1995-12-25", email: "joao@email.com", telefone: "(86) 99999-0000")

puts 'Criando livros...'
l1 = Livro.create!(titulo: "Dom Casmurro", autor: "Machado de Assis", editora: "Carambaia", isbn: "9781", quantidade_estoque: 5)
l2 = Livro.create!(titulo: "O Alquimista", autor: "Paulo Coelho", editora: "Paralela", isbn: "9782", quantidade_estoque: 3)
l3 = Livro.create!(titulo: "Harry Potter", autor: "J.K. Rowling", editora: "Rocco", isbn: "9783", quantidade_estoque: 8)
l4 = Livro.create!(titulo: "1984", autor: "George Orwell", editora: "Companhia", isbn: "9784", quantidade_estoque: 2)
l5 = Livro.create!(titulo: "O Hobbit", autor: "J.R.R. Tolkien", editora: "Martins", isbn: "9785", quantidade_estoque: 4)
l6 = Livro.create!(titulo: "Cem Anos de Solidão", autor: "Gabriel García Márquez", editora: "Record", isbn: "9786", quantidade_estoque: 6)
l7 = Livro.create!(titulo: "A Metamorfose", autor: "Franz Kafka", editora: "Penguin", isbn: "9787", quantidade_estoque: 2)
l8 = Livro.create!(titulo: "O Pequeno Príncipe", autor: "Antoine de Saint-Exupéry", editora: "Agir", isbn: "9788", quantidade_estoque: 9)
l9 = Livro.create!(titulo: "Ensaio sobre a Cegueira", autor: "José Saramago", editora: "Companhia", isbn: "9789", quantidade_estoque: 3)
l10 = Livro.create!(titulo: "Capitães da Areia", autor: "Jorge Amado", editora: "Companhia", isbn: "97810", quantidade_estoque: 5)

puts 'Criando empréstimos...'
# Criamos uma função helper dentro do seed para não repetir o preenchimento dos campos virtuais
def criar_emprestimo(aluno, livro, data_emp, data_dev, status)
  e = Emprestimo.new(
    aluno: aluno,
    livro: livro,
    data_emprestimo: data_emp,
    data_devolucao: data_dev,
    status: status,
    # Preenchemos os campos virtuais para passar na validação do seu Model
    aluno_id_input: aluno.id, 
    isbn_livro: livro.isbn
  )
  e.save! # Salva forçando a validação
end

# Agora chame a função:
criar_emprestimo(a1, l1, Date.today - 20, Date.today - 5, "Emprestado")
criar_emprestimo(a2, l2, Date.today - 15, Date.today - 2, "Emprestado")
criar_emprestimo(a3, l3, Date.today - 25, Date.today - 1, "Emprestado")
criar_emprestimo(a4, l4, Date.today - 2, Date.today + 5, "Emprestado")
criar_emprestimo(a5, l5, Date.today - 1, Date.today + 10, "Emprestado")
criar_emprestimo(a6, l6, Date.today - 5, Date.today + 2, "Emprestado")
criar_emprestimo(a7, l7, Date.today - 3, Date.today + 7, "Emprestado")
criar_emprestimo(a8, l8, Date.today - 30, Date.today - 20, "Devolvido")
criar_emprestimo(a9, l9, Date.today - 20, Date.today - 10, "Devolvido")
criar_emprestimo(a10, l10, Date.today - 15, Date.today - 5, "Devolvido")
puts 'Banco populado com sucesso!'
# "rails db:seed" insere esses dados
#
