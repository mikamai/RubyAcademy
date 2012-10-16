class List < ActiveRecord::Base
  attr_accessible :name

  has_many :todos

  validates_presence_of   :name
  validates_uniqueness_of :name
end
