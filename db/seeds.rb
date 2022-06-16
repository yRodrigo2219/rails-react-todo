# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "\nCriando usuários/to-do's com Faker..."

# Cria 100 usuarios
100.times {
  begin
    new_user = User.create!(name: Faker::Name.first_name) do |user|
      user.username = Faker::Internet.username(specifier: user.name, separators: "") + "#{Faker::Number.number(digits: 4)}"
      user.email = Faker::Internet.free_email(name: user.username)
      user.password = Faker::Internet.password(min_length: 6, max_length: 15)
    end
  
    # Cria 6 tarefas para cada usuario
    # (ao ver perfil, nem todos irão mostrar 6, já que algumas são privadas)
    6.times {
      new_user.todos.create!(title: "#{Faker::Verb.base} #{Faker::Name.name}", 
        description: Faker::Lorem.sentence(word_count: 10), 
        is_public: Faker::Boolean.boolean(true_ratio: 0.6),
        is_done: Faker::Boolean.boolean(true_ratio: 0.4))
    }
  rescue => exception
    # tentando criar usuarios duplicados
  end
}