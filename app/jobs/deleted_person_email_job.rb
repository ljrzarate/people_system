class DeletedPersonEmailJob < ActiveJob::Base
  queue_as :deleted_person_email

  def perform(name:, email:)
    Person.find_each do |person|
      PersonMailer.person_deleted(person, name, email).deliver_later
    end
  end
end
