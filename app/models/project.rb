class Project < ActiveRecord::Base
  has_many :project_members, dependent: :destroy
  has_many :users, through: :project_members
  has_many :pages, dependent: :destroy

  validates_presence_of :name
end
