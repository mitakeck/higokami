require './filters.rb'

# Node Parser
class NodeParser
  def initialize(selector)
    @selector = ''
    @filter = ObjectFilter.new
    tokenizer(selector)
  end

  def tokenizer(selector)
    selectors = []
    selector.split(' ').each do |token|
      case token
      when /.*{.*}/
        filter(token)
        break
      else
        selectors.push(token)
      end
    end
    @selector = selectors.join(' ')
  end

  def filter(token)
    case token
    when 'text{}'
      @filter = TextFilter.new
    when 'href{}'
      @filter = HrefFilter.new
    when 'html{}'
      @filter = HtmlFilter.new
    when /attr{(.*)}/
      @filter = AttrFilter.new($1)
    else
      raise UndefinedFilter
    end
  end

  def parse(doc)
    @filter.filter(doc.css(@selector))
  end
end
