module Urlable
  def initialize url
    @url = url

    url =~ /^([^\/]+)(.*)$/
    @domain = $1
    @path   = $2
  end

  def url
    @url
  end

  def domain
    @domain
  end

  def path
    @path
  end
end

Urlable.new
