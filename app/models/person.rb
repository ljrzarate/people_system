class Person < ActiveRecord::Base

  has_attached_file :picture,
                    url: "/assests/pictures/:id/:style/:basename.:extension",
                    path: ":rails_root/public/assests/pictures/:id/:style/:basename.:extension",
                    default_url: "/assests/pictures/missing.png"

  GENDERS = [
    "male",
    "female"
  ]

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

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    now = Time.current.utc.to_date
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  private
    def is_valid_birthdate?
      errors.add(:birthdate, 'Birthdate should be in the past') unless self.birthdate <= Date.current
    end
end
