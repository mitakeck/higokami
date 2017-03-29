require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require 'json'

require './nodeparser.rb'

Key = Struct.new(:key_org, :key, :is_array, :selector)

# key struct returner
def get_key(key)
  if (match = key.match(/(?<tkey>([^:]*)): ?`(?<selector>([^`]*))`/))
    case match[:tkey]
    when /(.*)\[\]/ then
      # this key has array value
      return Key.new(key, Regexp.last_match[1], true, match[:selector])
    else
      # this key has norm(not array) value
      return Key.new(key, match[:tkey], false, match[:selector])
    end
  end

  # on invalid syntax
  raise InvalidSyntaxKey
end

# value returner
def get_value(struct, doc, tkey, value)
  case value.to_s
  when 'string' then parse_node(doc, tkey)
  when /^{.*}$/ then
    # return norm value
    return serializer(struct[tkey[:key_org]], doc.css(tkey[:selector])) unless tkey[:is_array]

    # return array value
    result = []
    doc.css(tkey[:selector]).each do |node|
      result.push(serializer(struct[tkey[:key_org]], node))
    end

    # return
    result
  else
    # on invalid syntax
    raise InvalidSyntaxValue
  end
end

# key value to json serialize
def serializer(struct, doc)
  out = {}
  struct.each do |key, value|
    tkey = get_key(key)
    out[tkey[:key]] = get_value(struct, doc, tkey, value)
  end

  # retrun
  out
end
