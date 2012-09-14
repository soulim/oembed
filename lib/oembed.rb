# encoding: utf-8
require 'net/http'
require 'json'
require 'uri'
require 'rexml/document'

module Oembed
  class Error < StandardError; end

  class ResponseError < Error
    attr_reader :response

    def initialize(response)
      @response = response
    end
  end

  class RedirectionTooDeepError < Error; end

  class ParserError < Error
    attr_reader :original

    def initialize(original)
      @original = original
    end
  end

  class NotSupportedFormatError < Error; end

  autoload :Client, 'oembed/client'
  autoload :Parser, 'oembed/parser'
  autoload :XmlParser, 'oembed/xml_parser'
  autoload :Http, 'oembed/http'
  autoload :Uri, 'oembed/uri'
end

require 'oembed/version'
