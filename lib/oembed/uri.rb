# encoding: utf-8
require 'uri'

module Oembed
  class Uri
    def initialize(uri, query = {})
      @uri = URI.parse(uri)
      @uri.query = URI.encode_www_form(query) unless query.empty?
    end
    
    def https?
      @uri.kind_of?(URI::HTTPS)
    end
    
    def path
      @uri.request_uri
    end
  end
end