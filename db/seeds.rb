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
a1 = Aluno.create!(nome_completo: "Alice Silva", cpf: "111.001.212-21", data_nascimento: "1999-11-30", email: "alice@hotmail.com", telefone: "(86) 99999-1111")
a2 = Aluno.create!(nome_completo: "Bruno Costa", cpf: "222.002.028-22", data_nascimento: "2000-05-12", email: "bruno@gmail.com", telefone: "(86) 99999-2222")
a3 = Aluno.create!(nome_completo: "Carla Dias", cpf: "111.003.222-90", data_nascimento: "2001-08-20", email: "carla@hotmail.com", telefone: "(86) 99999-3333")
a4 = Aluno.create!(nome_completo: "Diego Farias", cpf: "222.004.111-78", data_nascimento: "1998-02-15", email: "diego@gmail.com", telefone: "(86) 99999-4444")
a5 = Aluno.create!(nome_completo: "Elisa Gomes", cpf: "111.005.211-22", data_nascimento: "2002-10-10", email: "elisa@gmail.com", telefone: "(86) 99999-5555")
a6 = Aluno.create!(nome_completo: "Fabio Lima", cpf: "333.006.696-68", data_nascimento: "1997-04-22", email: "fabio@gmail.com", telefone: "(86) 99999-6666")
a7 = Aluno.create!(nome_completo: "Gabriela Rosa", cpf: "111.007.090-22", data_nascimento: "2000-09-09", email: "gabriela@gmail.com", telefone: "(86) 99999-7777")
a8 = Aluno.create!(nome_completo: "Hugo Souza", cpf: "333.008.999-99", data_nascimento: "1999-01-30", email: "hugo@gmail.com", telefone: "(86) 99999-8888")
a9 = Aluno.create!(nome_completo: "Isabel Lima", cpf: "555.009.292-22", data_nascimento: "2003-03-14", email: "isabel@outlook.com", telefone: "(86) 99999-9999")
a10 = Aluno.create!(nome_completo: "João Pereira", cpf: "555.010.562-20", data_nascimento: "1995-12-25", email: "joao@hotmail.com", telefone: "(86) 99999-0000")
a11 = Aluno.create!(nome_completo: "Lucas Mendes", cpf: "111.011.000-11", data_nascimento: "1996-05-20", email: "lucas@outlook.com", telefone: "(86) 99999-0011")
a12 = Aluno.create!(nome_completo: "Mariana Souza", cpf: "111.012.000-22", data_nascimento: "2002-11-15", email: "mariana@hotmail.com", telefone: "(86) 99999-0012")
a13 = Aluno.create!(nome_completo: "Pedro Henrique", cpf: "111.013.000-33", data_nascimento: "1994-02-28", email: "pedro@hotmail.com", telefone: "(86) 99999-0013")
a14 = Aluno.create!(nome_completo: "Beatriz Oliveira", cpf: "999.014.000-44", data_nascimento: "2001-07-07", email: "beatriz@gmail.com", telefone: "(86) 99999-0014")
a15 = Aluno.create!(nome_completo: "Ricardo Santos", cpf: "111.015.000-55", data_nascimento: "1998-12-12", email: "ricardo@outlook.com", telefone: "(86) 99999-0015")
a16 = Aluno.create!(nome_completo: "Fernanda Lima", cpf: "987.016.000-66", data_nascimento: "1999-04-04", email: "fernanda@outlook.com", telefone: "(86) 99999-0016")
a17 = Aluno.create!(nome_completo: "Gustavo Alves", cpf: "456.017.000-77", data_nascimento: "2003-01-20", email: "gustavo@hotmail.com", telefone: "(86) 99999-0017")
a18 = Aluno.create!(nome_completo: "Larissa Rocha", cpf: "345.018.000-88", data_nascimento: "1997-06-30", email: "larissa@gmail.com", telefone: "(86) 99999-0018")
a19 = Aluno.create!(nome_completo: "Vinicius Moraes", cpf: "096.019.000-99", data_nascimento: "1995-09-15", email: "vinicius@outlook.com", telefone: "(86) 99999-0019")
a20 = Aluno.create!(nome_completo: "Camila Farias", cpf: "111.020.000-00", data_nascimento: "2000-03-25", email: "camila@outlook.com", telefone: "(86) 99999-0020")
a21 = Aluno.create!(nome_completo: "Ana Costa", cpf: "123.456.789-01", data_nascimento: "1995-05-10", email: "ana.costa@gmail.com", telefone: "(86) 99999-1001")
a22 = Aluno.create!(nome_completo: "Carlos Souza", cpf: "234.567.890-12", data_nascimento: "1996-06-11", email: "carlos.s@hotmail.com", telefone: "(86) 99999-1002")
a23 = Aluno.create!(nome_completo: "Bianca Lima", cpf: "345.678.901-23", data_nascimento: "1997-07-12", email: "blima@outlook.com", telefone: "(86) 99999-1003")
a24 = Aluno.create!(nome_completo: "Daniel Alves", cpf: "456.789.012-34", data_nascimento: "1998-08-13", email: "dan.alves@yahoo.com", telefone: "(86) 99999-1004")
a25 = Aluno.create!(nome_completo: "Eduarda Reis", cpf: "567.890.123-45", data_nascimento: "1999-09-14", email: "edu.reis@icloud.com", telefone: "(86) 99999-1005")
a26 = Aluno.create!(nome_completo: "Felipe Melo", cpf: "678.901.234-56", data_nascimento: "2000-10-15", email: "fmelo@gmail.com", telefone: "(86) 99999-1006")
a27 = Aluno.create!(nome_completo: "Giovanna Pires", cpf: "789.012.345-67", data_nascimento: "2001-11-16", email: "gpires@hotmail.com", telefone: "(86) 99999-1007")
a28 = Aluno.create!(nome_completo: "Henrique Silva", cpf: "890.123.456-78", data_nascimento: "2002-12-17", email: "hsilva@outlook.com", telefone: "(86) 99999-1008")
a29 = Aluno.create!(nome_completo: "Iara Santos", cpf: "901.234.567-89", data_nascimento: "1994-01-18", email: "iarasantos@gmail.com", telefone: "(86) 99999-1009")
a30 = Aluno.create!(nome_completo: "Jonas Moura", cpf: "101.112.131-41", data_nascimento: "1993-02-19", email: "jonasmoura@bol.com.br", telefone: "(86) 99999-1010")
a31 = Aluno.create!(nome_completo: "Katia Souza", cpf: "212.223.242-52", data_nascimento: "1992-03-20", email: "katia.s@gmail.com", telefone: "(86) 99999-1011")
a32 = Aluno.create!(nome_completo: "Leandro Costa", cpf: "323.334.353-63", data_nascimento: "1991-04-21", email: "leandro.c@hotmail.com", telefone: "(86) 99999-1012")
a33 = Aluno.create!(nome_completo: "Marina Oliveira", cpf: "434.445.464-74", data_nascimento: "1990-05-22", email: "marinao@outlook.com", telefone: "(86) 99999-1013")
a34 = Aluno.create!(nome_completo: "Nicolas Cage", cpf: "545.556.575-85", data_nascimento: "1989-06-23", email: "nic.cage@gmail.com", telefone: "(86) 99999-1014")
a35 = Aluno.create!(nome_completo: "Olivia Wilde", cpf: "656.667.686-96", data_nascimento: "1988-07-24", email: "oliviaw@hotmail.com", telefone: "(86) 99999-1015")
a36 = Aluno.create!(nome_completo: "Pablo Escobar", cpf: "767.778.797-07", data_nascimento: "1987-08-25", email: "pabloe@gmail.com", telefone: "(86) 99999-1016")
a37 = Aluno.create!(nome_completo: "Quiteria Maria", cpf: "878.889.808-18", data_nascimento: "1986-09-26", email: "quiteria@outlook.com", telefone: "(86) 99999-1017")
a38 = Aluno.create!(nome_completo: "Rafael Nader", cpf: "989.990.919-29", data_nascimento: "1985-10-27", email: "rnader@gmail.com", telefone: "(86) 99999-1018")
a39 = Aluno.create!(nome_completo: "Sabrina Sato", cpf: "191.011.121-30", data_nascimento: "1984-11-28", email: "sato@hotmail.com", telefone: "(86) 99999-1019")
a40 = Aluno.create!(nome_completo: "Tiago Iorc", cpf: "202.122.232-41", data_nascimento: "1983-12-29", email: "tiago@outlook.com", telefone: "(86) 99999-1020")
a41 = Aluno.create!(nome_completo: "Ursula Corbero", cpf: "313.233.343-52", data_nascimento: "1982-01-30", email: "ursula@gmail.com", telefone: "(86) 99999-1021")
a42 = Aluno.create!(nome_completo: "Victor Hugo", cpf: "424.344.454-63", data_nascimento: "1981-02-01", email: "vhugo@hotmail.com", telefone: "(86) 99999-1022")
a43 = Aluno.create!(nome_completo: "Wagner Moura", cpf: "535.455.565-74", data_nascimento: "1980-03-02", email: "wmoura@outlook.com", telefone: "(86) 99999-1023")
a44 = Aluno.create!(nome_completo: "Xuxa Meneghel", cpf: "646.566.676-85", data_nascimento: "1979-04-03", email: "xuxa@gmail.com", telefone: "(86) 99999-1024")
a45 = Aluno.create!(nome_completo: "Yuri Gagarin", cpf: "757.677.787-96", data_nascimento: "1978-05-04", email: "yuri@hotmail.com", telefone: "(86) 99999-1025")
a46 = Aluno.create!(nome_completo: "Zeca Pagodinho", cpf: "868.788.898-07", data_nascimento: "1977-06-05", email: "zeca@outlook.com", telefone: "(86) 99999-1026")
a47 = Aluno.create!(nome_completo: "Amanda Seyfried", cpf: "979.899.909-18", data_nascimento: "1976-07-06", email: "amanda@gmail.com", telefone: "(86) 99999-1027")
a48 = Aluno.create!(nome_completo: "Bruno Gagliasso", cpf: "181.910.121-29", data_nascimento: "1975-08-07", email: "bruno@hotmail.com", telefone: "(86) 99999-1028")
a49 = Aluno.create!(nome_completo: "Caio Castro", cpf: "292.021.232-30", data_nascimento: "1974-09-08", email: "caio@outlook.com", telefone: "(86) 99999-1029")
a50 = Aluno.create!(nome_completo: "Debora Falabella", cpf: "303.132.343-41", data_nascimento: "1973-10-09", email: "debora@gmail.com", telefone: "(86) 99999-1030")

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
l11 = Livro.create!(titulo: "O Crime do Padre Amaro", autor: "Eça de Queirós", editora: "Lello", isbn: "97811", quantidade_estoque: 4)
l12 = Livro.create!(titulo: "A Moreninha", autor: "Joaquim Manuel de Macedo", editora: "Ática", isbn: "97812", quantidade_estoque: 2)
l13 = Livro.create!(titulo: "Grande Sertão: Veredas", autor: "Guimarães Rosa", editora: "Nova Fronteira", isbn: "97813", quantidade_estoque: 3)
l14 = Livro.create!(titulo: "O Retrato de Dorian Gray", autor: "Oscar Wilde", editora: "Penguin", isbn: "97814", quantidade_estoque: 5)
l15 = Livro.create!(titulo: "Memórias Póstumas de Brás Cubas", autor: "Machado de Assis", editora: "Penguin", isbn: "97815", quantidade_estoque: 6)
l16 = Livro.create!(titulo: "Frankenstein", autor: "Mary Shelley", editora: "Darkside", isbn: "97816", quantidade_estoque: 4)
l17 = Livro.create!(titulo: "Orgulho e Preconceito", autor: "Jane Austen", editora: "Zahar", isbn: "97817", quantidade_estoque: 7)
l18 = Livro.create!(titulo: "O Processo", autor: "Franz Kafka", editora: "Companhia", isbn: "97818", quantidade_estoque: 2)
l19 = Livro.create!(titulo: "A Revolução dos Bichos", autor: "George Orwell", editora: "Globo", isbn: "97819", quantidade_estoque: 10)
l20 = Livro.create!(titulo: "Sapiens: Uma Breve História da Humanidade", autor: "Yuval Noah Harari", editora: "L&PM", isbn: "97820", quantidade_estoque: 3)

puts 'Criando empréstimos...'
def criar_emprestimo(aluno, livro, data_emp, data_dev, status)
  e = Emprestimo.new(
    aluno: aluno,
    livro: livro,
    data_emprestimo: data_emp,
    data_devolucao: data_dev,
    status: status,
    # Preenchemos os campos virtuais para passar na validação do Model
    aluno_id_input: aluno.id, 
    isbn_livro: livro.isbn
  )
  e.save! # Salva forçando a validação
end

# Agora chame a função:
criar_emprestimo(a1, l1, Date.today - 20, Date.today - 5, "Emprestado")
criar_emprestimo(a2, l1, Date.today - 15, Date.today - 2, "Emprestado")
criar_emprestimo(a3, l2, Date.today - 25, Date.today - 1, "Emprestado")
criar_emprestimo(a4, l4, Date.today - 2, Date.today + 5, "Emprestado")
criar_emprestimo(a5, l5, Date.today - 1, Date.today + 10, "Emprestado")
criar_emprestimo(a6, l6, Date.today - 5, Date.today + 2, "Emprestado")
criar_emprestimo(a7, l7, Date.today - 3, Date.today + 7, "Emprestado")
criar_emprestimo(a8, l8, Date.today - 30, Date.today - 20, "Devolvido")
criar_emprestimo(a9, l9, Date.today - 20, Date.today - 10, "Devolvido")
criar_emprestimo(a10, l4, Date.today - 15, Date.today - 5, "Devolvido")
criar_emprestimo(a11, l11, Date.today - 10, Date.today + 5, "Emprestado")
criar_emprestimo(a12, l12, Date.today - 30, Date.today - 15, "Devolvido")
criar_emprestimo(a13, l13, Date.today - 5, Date.today + 10, "Emprestado")
criar_emprestimo(a14, l14, Date.today - 12, Date.today + 3, "Emprestado")
criar_emprestimo(a15, l14, Date.today - 40, Date.today - 25, "Devolvido")
criar_emprestimo(a16, l4, Date.today - 2, Date.today + 13, "Emprestado")
criar_emprestimo(a17, l9, Date.today - 8, Date.today + 7, "Emprestado")
criar_emprestimo(a18, l8, Date.today - 25, Date.today - 10, "Devolvido")
criar_emprestimo(a19, l9, Date.today - 1, Date.today + 14, "Emprestado")
criar_emprestimo(a20, l2, Date.today - 50, Date.today - 35, "Devolvido")
criar_emprestimo(a21, l1, Date.today - 5, Date.today + 5, "Emprestado")
criar_emprestimo(a22, l2, Date.today - 10, Date.today, "Devolvido")
criar_emprestimo(a23, l3, Date.today - 2, Date.today + 8, "Emprestado")
criar_emprestimo(a24, l4, Date.today - 20, Date.today - 5, "Devolvido")
criar_emprestimo(a25, l5, Date.today - 1, Date.today + 10, "Emprestado")
criar_emprestimo(a26, l6, Date.today - 15, Date.today - 2, "Devolvido")
criar_emprestimo(a27, l7, Date.today - 3, Date.today + 7, "Emprestado")
criar_emprestimo(a28, l8, Date.today - 30, Date.today - 10, "Devolvido")
criar_emprestimo(a29, l9, Date.today - 7, Date.today + 3, "Emprestado")
criar_emprestimo(a30, l10, Date.today - 12, Date.today - 2, "Devolvido")
criar_emprestimo(a31, l11, Date.today - 4, Date.today + 6, "Emprestado")
criar_emprestimo(a32, l12, Date.today - 25, Date.today - 5, "Devolvido")
criar_emprestimo(a33, l13, Date.today - 8, Date.today + 2, "Emprestado")
criar_emprestimo(a34, l14, Date.today - 15, Date.today - 1, "Devolvido")
criar_emprestimo(a35, l15, Date.today - 2, Date.today + 13, "Emprestado")
criar_emprestimo(a36, l16, Date.today - 9, Date.today + 1, "Emprestado")
criar_emprestimo(a37, l17, Date.today - 5, Date.today + 5, "Emprestado")
criar_emprestimo(a38, l18, Date.today - 20, Date.today - 10, "Devolvido")
criar_emprestimo(a39, l19, Date.today - 1, Date.today + 14, "Emprestado")
criar_emprestimo(a40, l20, Date.today - 40, Date.today - 20, "Devolvido")
puts 'Banco populado com sucesso!'
# "rails db:seed" insere esses dados
#
