class DeletedPersonEmailJob < ActiveJob::Base
  queue_as :deleted_person_email

  # Public: Perform the execution of a background job to sent email to all the
  # people in the system when someone is deleted
  #
  # name  - The String name of the person deleted.
  # email - The String email of the person deleted.
  #
  # Examples
  #
  #   DeletedPersonEmailJob.perform_later("Tom", "tom@tom.com")
  #   # => #<DeletedPersonEmailJob:0x007fb61418f1d8 @arguments=["Tome", "tom@tom.com"], @job_id="b84664eb-0f80-468a-928c-ff369b7ed2af", @queue_name="deleted_person_email">
  #
  # Returns ActiveJob Object enqueued
  def perform(name:, email:)
    Person.find_each do |person|
      PersonMailer.person_deleted(person, name, email).deliver_later
    end
  end
end
