# Higokami
Higokami : tinny html scraper depend on Nokogiri


## Usage

Let's scrape Hacker News with Higokami

```ruby
require './higokami.rb'

# parse hacker news
higokami = Higokami.new('sample/news.ycombinator.com/index.json')
puts higokami.parse('https://news.ycombinator.com/')
```

```json
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

more sample is [here](https://github.com/mitakeck/higokami-json).
