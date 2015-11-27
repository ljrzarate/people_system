require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = FactoryGirl.build(:person)
  end

  test "should validate presence of first_name" do
    @person.first_name = nil
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }
  end

  test "should validate presence of last_name" do
    @person.last_name = nil
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }
  end

  test "should validate presence of email" do
    @person.save
    person2 = FactoryGirl.build(:person, email: nil)
    assert_raises(ActiveRecord::RecordInvalid) {
      person2.save!
    }

    person2.email = @person.email
    assert_raises(ActiveRecord::RecordInvalid) {
      person2.save!
    }

    person2.email = ("a" * 254) + "@test.com"
    assert_raises(ActiveRecord::RecordInvalid) {
      person2.save!
    }

    person2.email = "test@"
    assert_raises(ActiveRecord::RecordInvalid) {
      person2.save!
    }

    person2.email = "test@test.com"
    assert person2.save
  end

  test "should validate bio with maximum 500 characters" do
    @person.bio = "t" * 501
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }

    @person.bio = "bio of this dude"
    assert @person.save
  end

  test "should validate type or gender" do
    @person.gender = "weird"
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }

    @person.gender = "male"
    assert @person.save

    @person.gender = "female"
    assert @person.save
  end

  test "should validate presence of birthdate" do
    @person.birthdate = nil
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }

    @person.birthdate = Date.current - 1.year
    assert @person.save
  end

  test "should validate birthdate must be in the past" do
    @person.birthdate = Date.current + 1.day
    assert_raises(ActiveRecord::RecordInvalid) {
      @person.save!
    }
  end
end
