require 'net/http'

class Page
  include Urlable

  def response
    http = Net::HTTP.start(domain, 80)
    http.request_get(path)
  end
end
