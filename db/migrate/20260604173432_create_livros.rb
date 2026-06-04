class CreateLivros < ActiveRecord::Migration[8.1]
  def change
    create_table :livros do |t|
      t.string :titulo
      t.string :autor
      t.string :editora
      t.string :isbn
      t.integer :ano_publicacao
      t.integer :quantidade_estoque

      t.timestamps
    end
  end
end
