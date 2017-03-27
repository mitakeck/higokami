require './higokami.rb'

# parse hacker news
higokami = Higokami.new('sample/hacker_news.json')
puts higokami.parse('https://news.ycombinator.com/')

`
$ ruby test.rb
=> {
  "title": "Hacker News",
  "article": [
    {
      "title": "Deep Photo Style Transfergithub.com",
      "link": "https://github.com/luanfuj..."
    },
    {
      "title": "Gcam, the computational photogra...",
      "link": "https://blog.x.company/mee..."
    },
    ...
  ]
}
`
