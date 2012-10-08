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

items = []
items << Item.new('prendi il latte')
items << Item.new('lava i piatti')
items << Item.new('leggi _why')

DONE_SIGN = '☑'
TODO_SIGN = '☐'

items.each do |item|
  sign = item.done? ? DONE_SIGN : TODO_SIGN
  puts "#{sign} #{item.text}"
end
