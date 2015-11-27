# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
genders = ["male", "female"]
30.times do
  person = Person.new(
             first_name:  Faker::Name.first_name,
             last_name:   Faker::Name.last_name,
             email:       Faker::Internet.safe_email,
             bio:         Faker::Lorem.sentence(3),
             gender:      genders.sample,
             birthdate:   Faker::Date.backward(2555),
             job:         Faker::Company.profession
            )
  person.save!
end
