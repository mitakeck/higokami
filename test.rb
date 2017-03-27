require './higomori.rb'

# parse hacker news
higomori = Higomori.new('sample/hacker_news.json')
puts higomori.parse('https://news.ycombinator.com/')

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
