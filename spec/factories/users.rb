FactoryBot.define do
  factory :user do
    name 'Nome 1'
    email 'teste@email.com'
    password '123456'
    password_confirmation '123456'

    trait :invalid_email do
      email 'email'
    end
  end
end
