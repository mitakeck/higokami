require 'higokami/filters.rb'

# convert return node value by key type
def return_node(node, tkey, filters)
  # return single value
  unless tkey[:is_array]
    return filters.reduce(node) do |value, filter|
      filter.filter(value)
    end
  end

  # return array value
  result = []
  node.each do |n|
    result.push(filters.reduce(n) do |value, filter|
      filter.filter(value)
    end)
  end

  # return
  result
end

# update Nokogiri doc object by css selector
def update_doc(doc, selector)
  return doc if selector.length.zero?

  # retrun
  doc.css(selector)
end

# return struct
Selector = Struct.new(:selector, :filter)

# get css selector and filter function from user iuput
def parse_selector(selector)
  selectors = []
  filters = [ObjectFilter.new]
  selector.split(' ').each do |token|
    case token
    when /.*{.*}/ then filters.push(get_filter(token))
    else selectors.push(token)
    end
  end

  # return
  Selector.new(selectors.join(' '), filters)
end

# parse node element
def parse_node(doc, tkey)
  pselector = parse_selector(tkey[:selector])

  # return
  return_node(update_doc(doc, pselector[:selector]), tkey, pselector[:filter])
end
