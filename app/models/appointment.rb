class Appointment < ActiveRecord::Base
  attr_accessible :datetime, :message
  belongs_to :staff

  scope :old, lambda { where("datetime < ?", Time.zone.now) }

  validates :message, :presence => true
  validates :datetime, :presence => true
  validate :datetime_cannot_be_in_the_past

  def datetime_cannot_be_in_the_past
    if !datetime.blank? and datetime < Date.today
      errors.add(:datetime, "can't be in the past")
    end
  end

  def staff_name
    @name ||= self.staff.try(:name)
  end

  def date
    datetime.try(:to_date)
  end

  def summary
    return '' if message.blank?
    case
    when message.size > 10
      message[0...10] + '...'
    else
      message
    end
  end
end
