class Event < ApplicationRecord
  belongs_to :user
  belongs_to :community

  has_many :event_attendees, dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :user

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true

  def attendees_count
    attendees.count
  end
end
