class Poll < ApplicationRecord
  belongs_to :community
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :votes, through: :options

  accepts_nested_attributes_for :options, allow_destroy: true
end