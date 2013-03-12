require './page'

class PageStatus < Page
  def status
    response.code
  end
end
