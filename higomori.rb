require 'json'
require 'open-uri'
require 'nokogiri'

require './serializer.rb'

# Higomori
class Higomori
  def initialize(file_name)
    @file = File.read(file_name)
    @struct = JSON.parser.new(@file).parse
  end

  # parse
  def parse(url)
    @charset = nil
    @html = open(url) do |f|
      @charset = f.charset
      f.read
    end
    @doc = Nokogiri::HTML.parse(@html, nil, @charset)

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end
end
