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

Key = Struct.new(:key, :is_array)

def get_key(src)
  case src
  when /\[\](.*)/ then Key.new(Regexp.last_match[1], true)
  else Key.new(src, false)
  end
end

def serializer(struct)
  out = Hash.new
  struct.each do |key, value|
    p '-' * 30
    is_array = false
    tkey = ''
    if match = key.match(/(?<k1>([^:]*)):`(?<k2>([^`]*))`/)
      p get_key(match[:k1])
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

p get_key('[]hoge')
p get_key('aaa')
