class RemoveMatriculaFromAlunos < ActiveRecord::Migration[8.1]
  def change
    remove_column :alunos, :matricula, :string
  end
end
