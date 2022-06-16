FactoryBot.define do
  factory :random_todo, class: Todo do
    title { "#{Faker::Verb.base} #{Faker::Name.name}" }
    description { Faker::Lorem.sentence(word_count: 10) }
    is_done { Faker::Boolean.boolean(true_ratio: 0.6) }
    is_public { Faker::Boolean.boolean(true_ratio: 0.2) }
    user { :user }
  end

  factory :random_user, class: User do
    name { Faker::Name.first_name }
    username { Faker::Internet.username(specifier: name, separators: "") + "#{Faker::Number.number(digits: 4)}" }
    email { Faker::Internet.free_email(name: username) }
    password { Faker::Internet.password(min_length: 6, max_length: 15) }

    trait :with_todos do
      after(:create) do |user|
        create_list(:random_todo, 20, user: user)
      end
    end
  end
end