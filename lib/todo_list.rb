require 'yaml'
require 'item'

class TodoList
  def initialize path
    @path = File.expand_path(path)
  end

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

  attr_reader :path

  def items
    @items ||= File.exist?(path) ? YAML.load_file(path) : []
  end
end

