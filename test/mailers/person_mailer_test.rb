require 'test_helper'

class PersonMailerTest < ActionMailer::TestCase
  def setup
    2.times do
      FactoryGirl.create(:person)
    end
  end

  test "should sent email when new person is created" do
    new_person = FactoryGirl.create(:person)
    person = Person.first
    email = PersonMailer.person_created(person, new_person)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal ['peoplesystem@no-reply.com'], email.from
    assert_equal [person.email], email.to
    assert_equal 'People System - New person added', email.subject
  end

  test "should sent email when a person is deleted" do
    new_person = FactoryGirl.create(:person)
    person = Person.first
    email = PersonMailer.person_deleted(person, "just deleted", "just_deleted@test.com")
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal ['peoplesystem@no-reply.com'], email.from
    assert_equal [person.email], email.to
    assert_equal 'People System - Person deleted', email.subject
  end
end
