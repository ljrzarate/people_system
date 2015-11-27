class PersonMailer < ApplicationMailer

  def person_created(person, new_person)
    @person = person
    @new_person = new_person
    mail(
          to: @person.email,
          subject: 'People System - New person added'
        )
  end

  def person_deleted(person, deleled_person_name, deleted_person_email)
    @person = person
    @deleted_person_email = deleted_person_email
    @deleled_person_name = deleled_person_name
    mail(
          to: @person.email,
          subject: 'People System - Person deleted'
        )
  end
end
