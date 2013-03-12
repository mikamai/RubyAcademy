# coding: utf-8
require 'yaml'

class Item < Struct.new(:text)
  DONE_SIGN = '☑'
  TODO_SIGN = '☐'

  attr_accessor :done
  alias done? done

  def to_s
    sign = done? ? DONE_SIGN : TODO_SIGN
    "#{sign} #{text}"
  end
end


class TodoList
  def initialize path = '~/.ra-todos'
    @path = File.expand_path(path)
    @items = YAML.load_file(@path) if File.exist?(@path)
  end
  attr_reader :path

  def << text
    items.unshift Item.new(text)
  end

  def to_s
    items.join("\n")
  end

  def persist!
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

if ARGV.any?
  list << ARGV.join(' ')
  list.persist!
end

puts list





