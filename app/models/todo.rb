class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :developer, class_name: "User", optional: true

end