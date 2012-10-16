require 'spec_helper'

describe List do
  it 'requires a name' do
    list = List.new
    list.should have(1).error_on(:name)
  end

  it 'requires a unique name' do
    valid = List.create!(:name => 'my list')
    invalid = List.new(:name => valid.name)
    invalid.should have(1).error_on(:name)
  end
end
