class Community < ApplicationRecord
  belongs_to :user

  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy  

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true  
end
