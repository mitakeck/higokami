require 'json'

hoge = File.read('hacker_news.json')
json = JSON.parser.new(hoge)
hash = json.parse
hash.each do |key, value|
  puts "#{key} : #{value}"
end
