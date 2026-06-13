Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  resources :livros
  resources :alunos
  # Rota customizada para lidar com chaves compostas
  resources :emprestimos, param: :aluno_id, except: [:show, :edit, :update, :destroy]
  
  scope :emprestimos do
    get '/:aluno_id/:livro_id', to: 'emprestimos#show', as: :emprestimo
    get '/:aluno_id/:livro_id/edit', to: 'emprestimos#edit', as: :edit_emprestimo
    patch '/:aluno_id/:livro_id', to: 'emprestimos#update'
    delete '/:aluno_id/:livro_id', to: 'emprestimos#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Define a rota raiz para a página inicial do site
  root "home#index"
end
