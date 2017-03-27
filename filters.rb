# filter function interface
module FilterFunctionInterface
  def initialize
    @none = ''
  end

  def filter
    raise NotIMplementedError
  end

  def valid(doc)
    doc.text != @none
  end

  def child(doc)
    doc.children.length > 1
  end
end

# TextFilter class
class TextFilter
  include FilterFunctionInterface

  def filter(doc)
    if valid(doc)
      doc.text
    else
      @none
    end
  end
end

# HrefFilter class
class HrefFilter
  include FilterFunctionInterface

  def filter(doc)
    if valid(doc)
      doc.attribute('href').value
    else
      @none
    end
  end
end

# HtmlFilter class
class HtmlFilter
  include FilterFunctionInterface

  def filter(doc)
    doc.to_s
  end
end

# AttrFilter class
class AttrFilter
  include FilterFunctionInterface

  def initialize(key)
    @key = key
  end

  def filter(doc)
    if valid(doc)
      doc.attribute(@key).value
    else
      @none
    end
  end
end

# ObjectFilter
class ObjectFilter
  include FilterFunctionInterface

  def filter(doc)
    doc
  end
end

def get_filter(token)
  filter =
    case token
    when 'text{}'
      TextFilter.new
    when 'href{}'
      HrefFilter.new
    when 'html{}'
      HtmlFilter.new
    when /attr{(.*)}/
      AttrFilter.new(Regexp.last_match[1])
    else
      raise UndefinedFilter
    end
  filter
end
