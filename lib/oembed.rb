# encoding: utf-8

module Oembed
  autoload :Client, 'oembed/client'
  autoload :Http, 'oembed/http'
  autoload :Parser, 'oembed/parser'
  autoload :Uri, 'oembed/uri'
  autoload :XmlParser, 'oembed/xml_parser'
end

require 'oembed/errors'
require 'oembed/version'
