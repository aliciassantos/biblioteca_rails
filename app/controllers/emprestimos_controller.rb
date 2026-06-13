class EmprestimosController < ApplicationController
  before_action :set_emprestimo, only: %i[ show edit update destroy ]

  def index
    @emprestimos = Emprestimo.search(params[:search]).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      # GERAÇÃO DE PDF USANDO PRAWN
      format.pdf do
        pdf = Prawn::Document.new(page_size: "A4", page_layout: :portrait)

        # Título
        pdf.text "SISTEMA BIBLIOLILI&NANA", size: 22, style: :bold, align: :center, color: "003366"
        pdf.text "Relatório Geral de Empréstimos", size: 13, align: :center, color: "555555"
        pdf.move_down 25

        # 1. Cabeçalho com ID Aluno
        dados_tabela = [ [ "ID Aluno", "Aluno", "Livro", "Data Emp.", "Data Dev.", "Status" ] ]

        # 2. Loop preenchendo o aluno_id
        Emprestimo.search(params[:search]).each do |e|
          dados_tabela << [
            e.aluno_id.to_s,
            e.aluno&.nome_completo || "N/A",
            e.livro&.titulo || "N/A",
            e.data_emprestimo&.strftime('%d/%m/%Y'),
            e.data_devolucao&.strftime('%d/%m/%Y'),
            e.status
          ]
        end

        # 3. Estilização da tabela com ajuste de colunas
        pdf.table(dados_tabela, header: true, width: 520) do
          row(0).style(background_color: "212529", text_color: "FFFFFF", font_style: :bold)
          
          # Ajuste de largura: Coluna 0 (ID) com 60, colunas de datas com 65
          column(0).width = 60 
          column(3).width = 70
          column(4).width = 70
          
          self.row_colors = [ "FFFFFF", "F8F9FA" ]
        end

        # Rodapé
        pdf.move_down 30
        pdf.text "Relatório gerado em: #{Time.now.strftime('%d/%m/%Y às %H:%M')}", size: 9, style: :italic, align: :right

        send_data pdf.render, filename: "relatorio_emprestimos.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def show
  end

  def new
    @emprestimo = Emprestimo.new
  end

  def edit
  end

  def create
    @emprestimo = Emprestimo.new(emprestimo_params)

    if @emprestimo.save
      redirect_to emprestimos_path, notice: "Empréstimo registrado com sucesso."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @emprestimo.update(emprestimo_params)
      redirect_to emprestimos_path, notice: "Empréstimo atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @emprestimo.destroy!
    redirect_to emprestimos_path, notice: "Empréstimo removido com sucesso.", status: :see_other
  end

  private

  def set_emprestimo
    # Busca utilizando os dois campos da chave composta
    @emprestimo = Emprestimo.find_by!(aluno_id: params[:aluno_id], livro_id: params[:livro_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to emprestimos_path, alert: "Empréstimo não encontrado."
  end

  def emprestimo_params
    params.require(:emprestimo).permit(:aluno_id_input, :isbn_livro, :data_emprestimo, :data_devolucao, :status)
  end
end