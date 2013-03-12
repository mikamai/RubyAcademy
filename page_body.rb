require './page'
require './urlable'

class PageBody < Page
  include Enumerable

  def body
    response.body
  end

  def words
    body.scan(/\w+/)
  end

  def each(&block)
    words.each(&block)
  end
end
