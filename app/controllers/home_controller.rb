require "csv"

# CONTROLLER DA PÁGINA INICIAL DO SITE
class HomeController < ApplicationController
  def index
    # Pega todos os alunos para gerar o CSV
    @alunos = Aluno.all
    @livros = Livro.all

    respond_to do |format|
      format.html # Carrega a página normal da tela inicial
      format.csv do
        # Gera o CSV com os dados dos alunos
        if params[:tipo] == "alunos"
          csv_data = CSV.generate(headers: true) do |csv|
            csv << [ "id", "Nome Completo", "CPF", "Matrícula",  "Data de Nascimento", "E-mail", "Telefone", "Idade" ]
            # Adiciona cada aluno ao CSV, calculando a idade usando o método calcular_idade do modelo Aluno
            @alunos.each do |aluno|
              csv << [ aluno.id,
                aluno.nome_completo,
                aluno.cpf, aluno.matricula,
                aluno.data_nascimento, aluno.email,
                aluno.telefone,
                aluno.calcular_idade ]
            end
          end

          # Envia o arquivo CSV para download
          # "\xEF\xBB\xBF" garante que o Excel no Windows abra o arquivo sem Bagunçar os Acentos (BOM UTF-8)
          send_data "\xEF\xBB\xBF" + csv_data, filename: "alunos_completo.csv", type: "text/csv; charset=utf-8"
        else
          # Gera o CSV com os dados dos livros
          csv_data = CSV.generate(headers: true) do |csv|
            csv << [ "id", "Título", "Autor", "Editora", "ISBN",  "Ano de Publicação", "Quantidade em Estoque" ]
            # Adiciona cada livro ao CSV, calculando a idade usando o método calcular_idade do modelo Aluno
            @livros.each do |livro|
              csv << [
                livro.id,
                livro.titulo,
                livro.autor,
                livro.editora,
                livro.isbn,
                livro.ano_publicacao,
                livro.quantidade_estoque
              ]
            end
          end

          # Envia o arquivo CSV para download
          # "\xEF\xBB\xBF" garante que o Excel no Windows abra o arquivo sem Bagunçar os Acentos (BOM UTF-8)
          send_data "\xEF\xBB\xBF" + csv_data, filename: "livro_completo.csv", type: "text/csv; charset=utf-8"
        end
      end
    end
  end
end
