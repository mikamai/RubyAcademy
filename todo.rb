# coding: utf-8
require 'yaml'

class Item < Struct.new(:text)
  attr_accessor :done
  alias done? done

  DONE_SIGN = '☑'
  TODO_SIGN = '☐'

  def to_s
    sign = done? ? DONE_SIGN : TODO_SIGN
    "#{sign} #{text}"
  end
end


class TodoList
  def << text
    items << Item.new(text)
  end

  def to_s
    items.reverse.join("\n")
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

