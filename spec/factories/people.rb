# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    name { Faker::Name::first_name }
    surname { Faker::Name::last_name }
  end
end
