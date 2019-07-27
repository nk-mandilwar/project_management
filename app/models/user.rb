class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role

  #admin association
  has_many :projects, foreign_key: :creator_id
  has_many :todos, foreign_key: :creator_id

  #developer association
  has_many :tasks, class_name: "Todo", foreign_key: :developer_id
  has_and_belongs_to_many :assignments, class_name: "Project"

  module Roles
    roles = Role.all
    const_set 'all'.upcase, roles
  end

  Roles::ALL.each do |role|
    method_name = "#{role.internal_identifier}?"
    define_method(method_name.to_sym) do
      self.role_id == role.id
    end
  end
end
