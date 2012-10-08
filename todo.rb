# coding: utf-8
require 'yaml'

class Item < Struct.new(:text)
  attr_accessor :done
  alias done? done
end


class TodoList
  def << text
    items << Item.new(text)
  end

  def to_s
    items.reverse.map do |item|
      sign = item.done? ? DONE_SIGN : TODO_SIGN
      "#{sign} #{item.text}"
    end.join("\n")
  end

  def persist!
    path = File.expand_path('~/.ra-todos')
    File.open(path, 'w') do |file|
      file << items.to_yaml
    end
  end


  private

  def items
    @items ||= []
  end

  DONE_SIGN = '☑'
  TODO_SIGN = '☐'
end

list = TodoList.new
list << 'prendi il latte'
list << 'lava i piatti'
list << 'leggi _why'

unless ARGV.empty?
  list << ARGV.join(' ')
  list.persist!
end

puts list

