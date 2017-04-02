require './higokami.rb'

# parse hacker news
higokami = Higokami.new('sample/news.ycombinator.com/index.json')
puts higokami.parse('https://news.ycombinator.com/')
