require 'json'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'

require 'higokami/serializer.rb'

# Higokami
class Higokami
  def initialize(file_name)
    @file = File.read(file_name)
    @struct = JSON.parser.new(@file).parse
  end

  # parse
  def url(url)
    @charset = nil
    @html = open(url, 'User-Agent' => 'Higokami/0.0.1',
                      allow_redirections: :safe) do |f|
      @charset = f.charset
      f.read
    end
    @doc = Nokogiri::HTML.parse(@html, nil, @charset)

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end

  def html(html)
    @doc = Nokogiri::HTML(html)

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end

  def file(file_name)
    @doc = File.open(file_name) { |f| Nokogiri::XML(f) }

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end
end
