require './page_body'
require './page_status'

page = PageBody.new('www.ruby-lang.org/en/about/license.txt')
puts page.url
words = page.words
p words.select {|w| w =~ /^r/i}
p page.select {|w| w =~ /^r/i}


page2 = PageStatus.new('www.ruby-lang.org/en/about/license.txt')
puts page2.url
puts page2.status
