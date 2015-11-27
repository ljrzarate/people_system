class NewPersonEmailJob < ActiveJob::Base
  queue_as :new_person_email

  def perform(new_person_id)
    new_person = Person.find(new_person_id)
    Person.where.not(id: new_person_id).find_each do |person|
      PersonMailer.person_created(person, new_person).deliver_later
    end
  end
end
