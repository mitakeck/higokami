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
    when /.*{.*}/
      filter = get_filter(token)
      break
    else
      raise UndefinedFilter
    end
  end

  def parse(doc)
    @filter.filter(doc.css(@selector))
  end
end
