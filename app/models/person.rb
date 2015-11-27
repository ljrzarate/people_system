class Person < ActiveRecord::Base
  GENDERS = [ "male", "female"]

  has_attached_file :picture,
                    url: "/assests/pictures/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assests/pictures/:id/:style/:basename.:extension",
                    default_url: "/assests/pictures/missing.png"

  validates :first_name,  presence: true, length: { maximum: 75 }
  validates :last_name,   presence: true, length: { maximum: 75 }
  validates :email,       presence: true, uniqueness: true, length: { maximum: 254 },
                          format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :bio,         length: {maximum: 500}
  validates :gender,      presence: true, inclusion: {in: GENDERS}
  validates :birthdate,   presence: true
  validate :is_valid_birthdate?
  validates_attachment :picture, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates_with AttachmentSizeValidator, attributes: :picture, less_than: 5.megabytes

  scope :order_by_full_name, ->{order("first_name, last_name")}

  # Public: Join of first_name and last_name to return the full name of a person.
  #
  # Returns the full name String
  def full_name
    "#{first_name} #{last_name}"
  end

  # Public: Get the current time and the date of birth of the person and calculate the age
  #
  # Examples
  #
  #   Person.first.age
  #   # => 24
  #
  # Returns the age of a person Integer.
  def age
    now = Time.current.utc.to_date
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  private
    # Private: Add error if the birthdate is greater then current date
    #
    # Returns the duplicated String.
    def is_valid_birthdate?
      errors.add(:birthdate, 'should be in the past') unless self.birthdate && self.birthdate <= Date.current
    end
end
