class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :communities
  has_many :events
  has_many :posts

  # agregado César
  has_many :polls
  has_many :votes

  has_many :event_attendees, dependent: :destroy
  has_many :attended_events, through: :event_attendees, source: :event
end
