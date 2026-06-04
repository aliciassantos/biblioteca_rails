json.extract! aluno, :id, :nome_completo, :cpf, :matricula, :data_nascimento, :email, :telefone, :created_at, :updated_at
json.url aluno_url(aluno, format: :json)
