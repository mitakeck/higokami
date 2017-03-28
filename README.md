# higokami
Higokami : tinny html scraper depend on Nokogiri


## Usage

```ruby:
require './higokami.rb'

# parse hacker news
higokami = Higokami.new('sample/news.ycombinator.com/index.json')
puts higokami.parse('https://news.ycombinator.com/')
```

```json:
{
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
```
