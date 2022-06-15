class DefaultTodos
  def self.create(user)
    user.todos.create(title: "Criar conta na Fazeres", 
                      description: "Fazer conta no melhor site de tarefas!", 
                      is_done: true, 
                      is_public: false)

    user.todos.create(title: "Avaliar a Fazeres", 
                      description: "Deixar uma grande nota!", 
                      is_done: false, 
                      is_public: false)

    user.todos.create(title: "Compartilhar com amigos", 
                      description: "Mostrar para todos eles essa fantastica ferramenta!", 
                      is_done: false, 
                      is_public: false)
    
    user.todos.create(title: "Esse to-do pode ser visto por outros usuários!", 
                      description: "Aqui você também pode ver as tarefas dos outros usuários (só as que eles quiserem!)", 
                      is_done: false, 
                      is_public: true)

  end
end