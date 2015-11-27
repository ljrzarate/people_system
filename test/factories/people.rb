FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :person do
    first_name        {Faker::Name.first_name}
    last_name         {Faker::Name.last_name}
    email
    bio               {Faker::Lorem.sentence(3)}
    gender            {Person::GENDERS.sample}
    birthdate         {Faker::Date.backward(2555)}
    job               {Faker::Company.profession}
    picture_file_name {Faker::Avatar.image}
  end
end
