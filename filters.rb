# filter function interface
module FilterFunctionInterface
  def initialize
    @none = ''
  end

  def filter
    raise NotImplementedError
  end

  def valid(doc)
    doc.text != @none
  end

  def child(doc)
    doc.children.length > 1
  end

  def nokogiri?(doc)
    doc.class == Nokogiri::XML::NodeSet
  end
end

# TextFilter class
class TextFilter
  include FilterFunctionInterface

  def filter(doc)
    return doc.to_s unless nokogiri?(doc)
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
    return doc.to_s unless nokogiri?(doc)
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
    return doc.to_s unless nokogiri?(doc)
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

# TrimFilter
class TrimFilter
  include FilterFunctionInterface

  def filter(doc)
    doc = TextFilter.new.filter(doc) if nokogiri?(doc)
    doc.strip!
  end
end

# MatchFilter
class MatchFilter
  include FilterFunctionInterface

  def initialize(pattern)
    @pattern = pattern
  end

  def filter(doc)
    doc = TextFilter.new.filter(doc) if nokogiri?(doc)
    reuslt = doc.match(@pattern)
    return reuslt[0] if count(reuslt) > 0
    ''
  end
end

def get_filter(token)
  filter =
    case token
    when 'text{}' then TextFilter.new
    when 'href{}' then HrefFilter.new
    when 'html{}' then HtmlFilter.new
    when 'trim{}' then TrimFilter.new
    when /attr{(.*)}/ then AttrFilter.new(Regexp.last_match[1])
    when /match{(.*)}/ then MatchFilter.new(Regexp.last_match[1])
    else raise UndefinedFilter
    end
  filter
end
