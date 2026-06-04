class CreateAlunos < ActiveRecord::Migration[8.1]
  def change
    create_table :alunos do |t|
      t.string :nome_completo
      t.string :cpf
      t.string :matricula
      t.date :data_nascimento
      t.string :email
      t.string :telefone

      t.timestamps
    end
  end
end
