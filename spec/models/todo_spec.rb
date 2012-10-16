require 'spec_helper'

describe Todo do
  it 'is not completed by default' do
    subject.should_not be_completed
  end

  it 'has list association' do
    should respond_to(:list)
  end

  it 'requires #name attribute' do
    invalid = Todo.new
    invalid.should have(1).error_on(:name)
  end

  describe '#name' do
    let(:list) { List.create!(:name => 'list') }
    let(:todo) { Todo.create!(:name => 'wash dishes', :list => list) }
    let(:other_list) { List.create!(:name => 'other list') }

    context 'when name is not unique in the list context' do
      it 'is not valid' do
        invalid = Todo.new(:list => list, :name => todo.name)
        invalid.should have(1).error_on(:name)
      end
    end

    context 'when name is not unique among different lists' do
      it 'is valid' do
        valid = Todo.new(:list => other_list, :name => todo.name)
        valid.should be_valid
      end
    end
  end
end
