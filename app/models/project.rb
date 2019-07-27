class Project < ApplicationRecord
  self.per_page = 25
  
  belongs_to :creator, class_name: "User"
  has_many :todos
  has_and_belongs_to_many :developers, class_name: "User"

  validates :name, presence: true, uniqueness: {message: 'Project name already exists.'} 
end
