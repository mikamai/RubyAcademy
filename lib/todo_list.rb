require 'yaml'
require 'item'

class TodoList
  def initialize path = '~/.ra-todos'
    @path = File.expand_path(path)
  end

  def << text
    items.unshift Item.new(text)
    persist!
  end

  def to_s type = :all
    case type
    when :todo then todo
    when :done then done
    else [done, '', todo]
    end.join("\n")
  end

  def do!
    todo.first.done!
    persist!
  end


  private

  attr_reader :path

  def todo
    items.reject(&:done?)
  end

  def done
    items.select(&:done?)
  end

  def items
    @items ||= File.exist?(path) ? YAML.load_file(path) : []
  end

  def persist!
    File.open(path, 'w') do |file|
      file << items.to_yaml
    end
  end
end

