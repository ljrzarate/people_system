class Person < ActiveRecord::Base

  validates :first_name,  presence: true, length: { maximum: 75 }
  validates :last_name,   presence: true, length: { maximum: 75 }
  validates :email,       presence: true, uniqueness: true, length: { maximum: 254 },
                          format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :bio,         length: {maximum: 500}
  validates :gender,      presence: true, inclusion: {in: %w(male female)}
  validates :birthdate,   presence: true
  validate :is_valid_birthdate?


  private
    def is_valid_birthdate?
      if birthdate <= Date.current
        errors.add(:birthdate, 'Sorry, Invalid Date of Birth Entered.')
      end
    end
end
