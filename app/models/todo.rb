class Todo < ApplicationRecord
  default_scope { order(is_done: :asc) }

  belongs_to :user
  validates :title, presence: true, length: { in: 3..50 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :is_done, inclusion: { in: [ true, false ] }
  validates :is_public, inclusion: { in: [ true, false ] }
end
