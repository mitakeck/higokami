require 'open-uri'
require 'nokogiri'
require 'json'

require './nodeparser.rb'

file = File.read('sample/hacker_news.json')
struct = JSON.parser.new(file).parse
# url = 'https://news.ycombinator.com/'
# charset = nil
# html = open(url) do |f|
#   charset = f.charset
#   f.read
# end
# doc = Nokogiri::HTML.parse(html, nil, charset)

def serializer(struct)
  out = Hash.new
  struct.each do |key, value|
    p '-' * 30
    tkey = ''
    if match = key.match(/(?<k1>([^:]*)):`(?<k2>([^`]*))`/)
      if is_array = match[:k1].match(/\[\].*/)
        p 'array key'
      end
      tkey = match[:k1]
      p match[:k2]
    else
      raise InvalidSyntaxKey
    end

    case value.to_s
    when 'string'
      p 'string'
    when /^{.*}$/
      p 'object'
      serializer(struct[key])
    else
      raise InvalidSyntaxValue
    end
  end

  out
end

serializer(struct)
