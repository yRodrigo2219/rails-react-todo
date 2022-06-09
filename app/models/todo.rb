class Todo < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { in: 3..50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :is_done, presence: true
  validates :is_public, presence: true
end
