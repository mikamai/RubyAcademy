class Todo < ActiveRecord::Base
  attr_accessible :name, :completed, :list_id, :list

  belongs_to :list

  validates_presence_of   :name
  validates_uniqueness_of :name, :scope => :list_id
end
