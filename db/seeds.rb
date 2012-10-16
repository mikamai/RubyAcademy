# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

List.delete_all
Todo.delete_all

puts 'create some example lists'
['pet projects', 'work todos'].each do |name|
  List.create!(:name => name)
end

puts 'create some example todos'
['send rocket to the moon', 'finish todos app'].each do |name|
  List.find_each do |list|
    list.todos.create(:name => name)
  end
end

puts 'setup completed.'
