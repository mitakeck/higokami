$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'json'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'

require 'serializer.rb'

# Higokami
class Higokami
  def initialize(file_name)
    @file = File.read(file_name)
    @struct = JSON.parser.new(@file).parse
  end

  # parse
  def parse(url)
    @charset = nil
    @html = open(url, 'User-Agent' => 'Higokami/0.0.1', allow_redirections: :safe) do |f|
      @charset = f.charset
      f.read
    end
    @doc = Nokogiri::HTML.parse(@html, nil, @charset)

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end
end
