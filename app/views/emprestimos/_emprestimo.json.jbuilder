json.extract! emprestimo, :id, :aluno_id, :livro_id, :data_emprestimo, :data_devolucao, :status, :created_at, :updated_at
json.url emprestimo_url(emprestimo, format: :json)
