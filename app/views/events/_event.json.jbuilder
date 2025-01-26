json.extract! event, :id, :name, :description, :date, :user_id, :community_id, :created_at, :updated_at
json.url event_url(event, format: :json)
json.attendees_count event.attendees_count
