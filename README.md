# README

## Como executar

### Pre-requisitos
  - SQLite3
  - Ruby 2.6

### Comandos
 -  $ `bundle install`
 -  $ `rake db:migrate`
 -  $ `rails s`

## Tabela de Rotas

| Endpoint                            	| Método 	| Descrição                                                	|
|-------------------------------------	|--------	|----------------------------------------------------------	|
| /auth/login                         	| POST   	| Gera token de autenticação                               	|
| /auth/rsa-key                       	| GET    	| Retorna a Public-Key RSA para criptografar senha         	|
| /api/v1/users                       	| POST   	| Cria o usuário                                           	|
| /api/v1/users/{username}            	| GET    	| Retorna usuário em especifico                           	|
| /api/v1/users/{username}            	| PUT    	| Altera informações do usuário                            	|
| /api/v1/users/{username}            	| DELETE 	| Deleta usuário em especifico                             	|
| /api/v1/users/{username}/todos      	| GET   	| Retorna lista de tarefas do usuário                      	|
| /api/v1/users/{username}/todos      	| POST   	| Cria uma nova tarefa para o usuário                      	|
| /api/v1/users/{username}/todos/{id} 	| PUT    	| Altera uma tarefa do usuário                             	|
| /api/v1/users/{username}/todos/{id} 	| DELETE 	| Deleta uma tarefa do usuário                             	|

## Features

- [x] Tarefas pública todos usuários logados podem visualizar
- [x] Tarefas privadas apenas o usuário que criou pode visualizar
- [x] Listar as tarefas cadastradas conforme a visibilidade, pública ou privada (?visibility=[public/private] no GET /todos)
- [x] Listar as tarefas cadastradas conforme o status, nova ou concluída (?status=[done/not_done] no GET /todos)
- [x] Permitir marcar uma tarefa como concluída
- [x] Poder editar uma tarefa
- [x] Uma tarefa concluída não pode ser editada, apenas visualizada (precisa ser desmarcada para poder ser editada)
- [ ] Povoar o banco com uma lista default de tarefas (usar Faker)
- [x] Criar uma autenticação básica para o sistema (JWT)
- [x] RSA para cryptografar a passagem da senha