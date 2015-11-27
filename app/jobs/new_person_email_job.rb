class NewPersonEmailJob < ActiveJob::Base
  queue_as :new_person_email

  # Public: Perform the execution of a background job to sent email to all the
  # people in the system when someone is created except the same person
  #
  # new_person_id  - The Integet id of the person just created
  #
  # Examples
  #
  #   NewPersonEmailJob.perform_later(1)
  #   # => #<DeletedPersonEmailJob:0x007fb61418f1d8 @arguments=["Tome", "tom@tom.com"], @job_id="b84664eb-0f80-468a-928c-ff369b7ed2af", @queue_name="deleted_person_email">
  #
  # Returns ActiveJob Object enqueued
  def perform(new_person_id)
    new_person = Person.find(new_person_id)
    Person.where.not(id: new_person_id).find_each do |person|
      PersonMailer.person_created(person, new_person).deliver_later
    end
  end
end
