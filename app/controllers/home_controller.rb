require "csv"

# CONTROLLER DA PÁGINA INICIAL DO SISTEMA
class HomeController < ApplicationController
  # Trava do Devise: Ninguém acessa NADA nesta página sem fazer login
  before_action :authenticate_user!

  def index
    # Carrega os dados necessários para os relatórios
    @alunos = Aluno.all
    @livros = Livro.all
    @emprestimos = Emprestimo.all

    respond_to do |format|
      format.html # Carrega a página index.html.erb

      format.csv do
        # Lógica para exportar lista de Alunos
        if params[:tipo] == "alunos"
          csv_data = CSV.generate(headers: true) do |csv|
            csv << [ "id", "Nome Completo", "CPF", "Data de Nascimento", "E-mail", "Telefone", "Idade" ]
            @alunos.each do |a|
              csv << [ a.id, a.nome_completo, a.cpf, a.data_nascimento, a.email, a.telefone, a.calcular_idade ]
            end
          end
          send_data "\xEF\xBB\xBF" + csv_data, filename: "alunos_completo.csv", type: "text/csv; charset=utf-8"

        # Lógica para exportar lista de Empréstimos
        elsif params[:tipo] == "emprestimos"
          csv_data = CSV.generate(headers: true) do |csv|
            csv << [ "ID", "Aluno", "Livro", "Data Empréstimo", "Data Devolução", "Status" ]
            @emprestimos.each do |e|
              csv << [
                e.id,
                e.aluno&.nome_completo,
                e.livro&.titulo,
                e.data_emprestimo,
                e.data_devolucao,
                e.status
              ]
            end
          end
          send_data "\xEF\xBB\xBF" + csv_data, filename: "emprestimos_completo.csv", type: "text/csv; charset=utf-8"

        # Lógica para exportar lista de Livros
        else
          csv_data = CSV.generate(headers: true) do |csv|
            csv << [ "id", "Título", "Autor", "Editora", "ISBN", "Ano de Publicação", "Quantidade em Estoque" ]
            @livros.each do |l|
              csv << [ l.id, l.titulo, l.autor, l.editora, l.isbn, l.ano_publicacao, l.quantidade_estoque ]
            end
          end
          send_data "\xEF\xBB\xBF" + csv_data, filename: "livro_completo.csv", type: "text/csv; charset=utf-8"
        end
      end
    end
  end
end
