require 'json'
require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'

require 'higokami/serializer.rb'

# Higokami
class Higokami
  def initialize(file_name)
    puts format('File not found: %s', file_name) unless File.exist?(file_name)
    @file = File.read(file_name)
    @struct = JSON.parser.new(@file).parse
  end

  # parse
  def parse(target)
    case target
    when %r{^https?.*} then url(target)
    else file(target)
    end
  end

  # parse from url
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

  # parse from html text
  def html(html)
    @doc = Nokogiri::HTML(html)

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end

  # parse from file
  def file(file_name)
    puts format('File not found: %s', file_name) unless File.exist?(file_name)
    @doc = File.open(file_name) { |f| Nokogiri::XML(f) }

    # return
    JSON.pretty_generate(serializer(@struct, @doc))
  end
end
