class Todo < ApplicationRecord
  self.per_page = 25

  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User", optional: true

  validates :name, presence: true, uniqueness: {message: 'Todo name already exists.'} 

  enum status: [:open, :progress, :done]
end