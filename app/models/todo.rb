class Todo < ActiveRecord::Base
  attr_accessible :name, :completed, :list_id, :list
end
