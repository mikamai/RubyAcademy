# coding: utf-8

class Item < Struct.new(:text)

  attr_accessor :done
  alias done? done
  def done!
    self.done = true
  end

  DONE_SIGN = '☑'
  TODO_SIGN = '☐'

  def to_s
    sign = done? ? DONE_SIGN : TODO_SIGN
    "#{sign} #{text}"
  end

end
