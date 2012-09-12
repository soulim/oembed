# encoding: utf-8

module Oembed
  class Uri
    def initialize(endpoint_uri, resource_uri)
      @uri = URI.parse(endpoint_uri)
      @uri.query = URI.encode_www_form(url: resource_uri)
    end

    def to_s
      @uri.to_s
    end
  end
end
