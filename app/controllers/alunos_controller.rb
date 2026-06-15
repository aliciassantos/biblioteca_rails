class AlunosController < ApplicationController
  before_action :set_aluno, only: %i[ show edit update destroy ]

  # GET /alunos or /alunos.json
  def index
    # Integra a busca por contencimento e depois aplica a paginação do Kaminari
    @alunos = Aluno.search(params[:search]).page(params[:page]).per(5)

    respond_to do |format|
      format.html # Carrega a página index.html.erb com a barra de pesquisa compacta
      format.json { render json: Aluno.all }

      # REQUISITO D): Configura a geração de PDF usando a Gem Prawn
      format.pdf do
        pdf = Prawn::Document.new(page_size: "A4", page_layout: :portrait)

        # Título do documento PDF
        pdf.text "SISTEMA BIBLIOLILI&NANA", size: 22, style: :bold, align: :center, color: "003366"
        pdf.text "Relatório Geral de Alunos Cadastrados", size: 13, align: :center, color: "555555"
        pdf.move_down 25

        # Monta a estrutura de colunas e dados da tabela do PDF (Removido "Matrícula")
        dados_tabela = [ [ "ID", "Nome Completo", "CPF", "Idade" ] ]

        # Puxa os alunos baseando-se na pesquisa atual 
        Aluno.search(params[:search]).each do |aluno|
          dados_tabela << [
            aluno.id.to_s,
            aluno.nome_completo,
            aluno.cpf,
            "#{aluno.calcular_idade} anos"
          ]
        end

        # Estiliza a tabela dentro do PDF
        pdf.table(dados_tabela, header: true, width: 520) do
          row(0).style(background_color: "212529", text_color: "FFFFFF", font_style: :bold)
          columns(0).width = 50   # Largura para o ID
          columns(2).width = 110  # Largura para o CPF
          columns(3).width = 80   # Largura para a Idade
          self.row_colors = [ "FFFFFF", "F8F9FA" ] # Efeito zebrado
        end

        # Rodapé do relatório
        pdf.move_down 30
        pdf.text "Relatório gerado em: #{Time.now.strftime('%d/%m/%Y às %H:%M')}", size: 9, style: :italic, align: :right

        # Envia para exibição direta no navegador (inline)
        send_data pdf.render, filename: "relatorio_alunos.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /alunos/1 or /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
  end

  # GET /alunos/1/edit
  def edit
  end

  # POST /alunos or /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to @aluno, notice: "Aluno cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @aluno.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /alunos/1 or /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html { redirect_to @aluno, notice: "Cadastro do aluno atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @aluno.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /alunos/1 or /alunos/1.json
  def destroy
    @aluno.destroy!

    respond_to do |format|
      format.html { redirect_to alunos_path, notice: "Aluno removido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params[:id])
    end

    # Filtro de segurança (Strong Parameters) - Removido completamente o atributo :matricula
    def aluno_params
      params.require(:aluno).permit(:nome_completo, :cpf, :data_nascimento, :email, :telefone)
    end
end