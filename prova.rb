require 'net/http'

def get_body(url, &block)
  url =~ /^([^\/]+)(.*)$/
  domain = $1
  path   = $2
  Net::HTTP.start(domain, 80) do |http|
    http.request_get(path) do |response|
      block.call response.body, response.code
    end
  end
end


get_body 'www.ruby-lang.org/en/about/license.txt' do |body|
  puts body
end




# Net::HTTP.start( 'www.ruby-lang.org', 80 ) do |http|
#   print( http.get( '/en/about/license.txt' ).body )
# end

# http = Net::HTTP.start( 'www.ruby-lang.org', 80 )
# print( http.get( '/en/LICENSE.txt' ).body )
# http.finish
