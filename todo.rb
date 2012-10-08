# coding: utf-8

class Item
  def initialize text
    @text = text
  end

  def text
    @text
  end

  def done
    @done
  end

  def done= status
    @done = status
  end

  def done?
    @done
  end
end


class TodoList
  def << text
    items << Item.new(text)
  end

  private

  def items
    @items ||= []
  end

  DONE_SIGN = '☑'
  TODO_SIGN = '☐'

  def to_s
    items.map do |item|
      sign = item.done? ? DONE_SIGN : TODO_SIGN
      "#{sign} #{item.text}"
    end.join("\n")
  end
end

list = TodoList.new
list << 'prendi il latte'
list << 'lava i piatti'
list << 'leggi _why'

puts list
