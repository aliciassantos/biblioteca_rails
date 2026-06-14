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

puts 'Criando alunos'
aluno1 = Aluno.create!(
  nome_completo: "Alice Silva",
  cpf: "000.333.222-11",
  matricula: "2026001",
  data_nascimento: "1999-11-30",
  email: "alice@email.com",
  telefone: "(86) 99999-1111"
)

aluno2 = Aluno.create!(
  nome_completo: "Bruno Costa",
  cpf: "222.111.333-44",
  matricula: "2026002",
  data_nascimento: "2005-10-12",
  email: "bruno@email.com",
  telefone: "(86) 99999-2222"
)

puts 'Criando livros'
livro1 = Livro.create!(
  titulo: "Dom Casmurro",
  autor: "Machado de Assis",
  editora: "Editora Carambaia",
  isbn: "9788508044344",
  ano_publicacao: 1899,
  quantidade_estoque: 5
)

livro2 = Livro.create!(
  titulo: "O Alquimista",
  autor: "Paulo Coelho",
  editora: "Paralela",
  isbn: "9788575427583",
  ano_publicacao: 1988,
  quantidade_estoque: 3
)

puts 'Criando empréstimos'
Emprestimo.create!(
  aluno: aluno1,
  livro: livro1,
  data_emprestimo: Date.today,
  data_devolucao: Date.today + 7.days,
  status: "Emprestado"
)

Emprestimo.create!(
  aluno: aluno2,
  livro: livro2,
  data_emprestimo: Date.today - 10.days,
  data_devolucao: Date.today - 3.days, # Empréstimo que já venceu!
  status: "Emprestado"
)

puts 'Banco criado com sucesso'
# "rails db:seed" insere esses dados
#
