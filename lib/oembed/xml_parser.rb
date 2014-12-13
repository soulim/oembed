# encoding: utf-8
require 'oembed/errors'
require 'rexml/document'

module Oembed
  class XmlParser
    class << self
      def self.parse(source)
        begin
          document = REXML::Document.new(source)
          traverse(document.root)
        rescue REXML::ParseException => e
          raise Oembed::ParserError.new(e), 'XML parser error'
        end
      end

      private

      def self.traverse(node)
        node.elements.to_a.inject({}) do |accum, elem|
          accum[elem.name] = elem.has_elements? ? traverse(elem) : elem.text
          accum
        end
      end
    end
  end
end
