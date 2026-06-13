# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_13_182553) do
  create_table "alunos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.date "data_nascimento"
    t.string "email"
    t.string "nome_completo"
    t.string "telefone"
    t.datetime "updated_at", null: false
  end

  create_table "emprestimos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "aluno_id", null: false
    t.datetime "created_at", null: false
    t.date "data_devolucao"
    t.date "data_emprestimo"
    t.bigint "livro_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["aluno_id"], name: "index_emprestimos_on_aluno_id"
    t.index ["livro_id"], name: "index_emprestimos_on_livro_id"
  end

  create_table "livros", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "ano_publicacao"
    t.string "autor"
    t.datetime "created_at", null: false
    t.string "editora"
    t.string "isbn"
    t.integer "quantidade_estoque"
    t.string "titulo"
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "emprestimos", "alunos"
  add_foreign_key "emprestimos", "livros"
end
