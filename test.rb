require 'open-uri'
require 'nokogiri'

require './nodeparser.rb'

url = 'https://news.ycombinator.com/'
charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
np = NodeParser.new('#\31 3936153 > td:nth-child(3) > a text{}')
p np.parse(doc)
