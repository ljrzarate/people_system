class PersonMailer < ApplicationMailer
  # Public: Mail creation when a person is created
  #
  # person     - The Person object to sent the email
  # new_person - The new Person object who was just created
  #
  # Examples
  #
  #   PersonMailer.person_created(Person.first, Person.last)
  #   # => <Mail::Message:70210023348220, Multipart: true, Headers: <From: peoplesystem@no-reply.com>, <To: jason@example.org>, <Subject: People System - New person added>, <Mime-Version: 1.0>, <Content-Type: multipart/alternative; boundary="--==_mimepart_5658daba74890_88823fdb09c5e1fc7142f"; charset=UTF-8>>
  #
  # Returns the Mail object to be delivered
  def person_created(person, new_person)
    @person = person
    @new_person = new_person
    mail(
          to: @person.email,
          subject: 'People System - New person added'
        )
  end

  # Public: Mail creation when a person is deleted
  #
  # person               - The Person object to sent the email
  # deleled_person_name  - The String the person name just deleted
  # deleted_person_email - The String the person email just deleted
  #
  # Examples
  #
  #   PersonMailer.person_deleted(Person.first, "pepito", "pepito@perez.com")
  #   # => <Mail::Message:70210023348220, Multipart: true, Headers: <From: peoplesystem@no-reply.com>, <To: jason@example.org>, <Subject: People System - New person added>, <Mime-Version: 1.0>, <Content-Type: multipart/alternative; boundary="--==_mimepart_5658daba74890_88823fdb09c5e1fc7142f"; charset=UTF-8>>
  #
  # Returns the Mail object to be delivered
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
