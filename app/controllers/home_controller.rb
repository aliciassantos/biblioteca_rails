require "csv"

# CONTROLLER DA PÁGINA INICIAL DO SITE
class HomeController < ApplicationController
  def index
    # Pega todos os alunos para gerar o CSV
    @alunos = Aluno.all

    respond_to do |format|
      format.html # Carrega a página normal da tela inicial
      format.csv do
        # Gera o CSV com os dados dos alunos
        csv_data = CSV.generate(headers: true) do |csv|
          csv << [ "id", "Nome Completo", "CPF", "Matrícula",  "Data de Nascimento", "E-mail", "Telefone", "Idade" ]
          # Adiciona cada aluno ao CSV, calculando a idade usando o método calcular_idade do modelo Aluno
          @alunos.each do |aluno|
            csv << [ aluno.id, aluno.nome_completo, aluno.cpf, aluno.matricula, aluno.data_nascimento, aluno.email, aluno.telefone, aluno.calcular_idade ]
          end
        end

        # Envia o arquivo CSV para download
        send_data csv_data, filename: "alunos.csv", type: "text/csv"
      end
    end
  end
end
