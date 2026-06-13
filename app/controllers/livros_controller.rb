class LivrosController < ApplicationController
  before_action :set_livro, only: %i[ show edit update destroy ]

  # GET /livros or /livros.json
  def index
    # Aplica o método de busca multimoldura e depois a paginação do Kaminari (5 por página)
    @livros = Livro.search(params[:search]).page(params[:page]).per(5)

    respond_to do |format|
      format.html # Carrega a página index.html.erb normal no navegador
      format.json { render json: Livro.all }

      # REQUISITO D): Configura a geração de PDF usando a Gem Prawn
      format.pdf do
        pdf = Prawn::Document.new(page_size: "A4", page_layout: :portrait)

        # Título do documento PDF
        pdf.text "SISTEMA BIBLIOLILI&NANA", size: 22, style: :bold, align: :center, color: "003366"
        pdf.text "Relatório Geral de Livros Cadastrados", size: 13, align: :center, color: "555555"
        pdf.move_down 25

        # Monta a estrutura de colunas e dados da tabela do PDF
        dados_tabela = [ [ "ID", "Título da Obra", "Editora", "ISBN", "Ano de Publicação", "Quantidade em Estoque" ] ]

        # Puxa os livros filtrados pela busca atual (ou todos se não houver busca) para o PDF
        Livro.search(params[:search]).each do |livro|
          dados_tabela << [
            livro.id.to_s,
            livro.titulo,
            livro.editora,
            livro.isbn,
            livro.ano_publicacao.to_s,
            livro.quantidade_estoque.to_s
          ]
        end

        # Estiliza a tabela dentro do PDF
        pdf.table(dados_tabela, header: true, width: 520) do
          row(0).style(background_color: "212529", text_color: "FFFFFF", font_style: :bold)
          columns(0).width = 35 # Largura do ID
          columns(3).width = 90 # Largura do ISBN
          columns(4).width = 75 # Largura do Ano de Pub.
          columns(5).width = 75 # Largura da Qtd. Estoque
          self.row_colors = [ "FFFFFF", "F8F9FA" ] # Efeito zebrado
        end

        # Rodapé do relatório
        pdf.move_down 30
        pdf.text "Relatório gerado em: #{Time.now.strftime('%d/%m/%Y às %H:%M')}", size: 9, style: :italic, align: :right

        # Envia para exibição direta no navegador (inline)
        send_data pdf.render, filename: "relatorio_livros.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  # GET /livros/1 or /livros/1.json
  def show
  end

  # GET /livros/new
  def new
    @livro = Livro.new
  end

  # GET /livros/1/edit
  def edit
  end

  # POST /livros or /livros.json
  def create
    @livro = Livro.new(livro_params)

    respond_to do |format|
      if @livro.save 
        format.html { redirect_to @livro, notice: "Livro cadastrado com sucesso." }
        format.json { render :show, status: :created, location: @livro }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @livro.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /livros/1 or /livros/1.json
  def update
    respond_to do |format|
      if @livro.update(livro_params)
        format.html { redirect_to @livro, notice: "Livro atualizado com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @livro }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @livro.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /livros/1 or /livros/1.json
  def destroy
    @livro.destroy!

    respond_to do |format|
      format.html { redirect_to livros_path, notice: "Livro removido com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_livro
      @livro = Livro.find(params.expect(:id))
    end

    # Somente parâmetros permitidos através do Strong Parameters
    def livro_params
      params.expect(livro: [ :titulo, :autor, :editora, :isbn, :ano_publicacao, :quantidade_estoque ])
    end
end