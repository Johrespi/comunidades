class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy

  validates :title, presence: true
end
