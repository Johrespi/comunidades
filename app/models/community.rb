class Community < ApplicationRecord
  belongs_to :user

  # has_many :users, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy

  # agregado César
  has_many :polls, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  # AGREGADO LUIS INGA
  # Devuelve el número total de eventos creados en la comunidad
  def events_count
    self.events.count
  end

  # Devuelve el número total de publicaciones en la comunidad
  def posts_count
    self.posts.count
  end

  # Devuelve el número total de participantes en todos los eventos de la comunidad
  def total_attendees_count
    self.events.joins(:attendees).count
  end

  # Calcula el promedio de participantes por evento
  def average_attendees_per_event
    return 0 if events_count.zero?
    total_attendees_count / events_count
  end
end
