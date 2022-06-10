# README

### Tabela de Rotas

| Endpoint                            	| Método 	| Descrição                                                	|
|-------------------------------------	|--------	|----------------------------------------------------------	|
| /auth/login                         	| POST   	| Gera token de autenticação                               	|
| /auth/rsa-key                       	| GET    	| Retorna a Public-Key RSA para criptografar senha         	|
| /api/v1/users                       	| POST   	| Cria o usuário                                           	|
| /api/v1/users/{username}            	| GET    	| Retorna usuário em especifico (lista de to-do's incluso) 	|
| /api/v1/users/{username}            	| PUT    	| Altera informações do usuário                            	|
| /api/v1/users/{username}            	| DELETE 	| Deleta usuário em especifico                             	|
| /api/v1/users/{username}/todos      	| POST   	| Cria uma nova tarefa para o usuário                      	|
| /api/v1/users/{username}/todos/{id} 	| PUT    	| Altera uma tarefa do usuário                             	|
| /api/v1/users/{username}/todos/{id} 	| DELETE 	| Deleta uma tarefa do usuário                             	|