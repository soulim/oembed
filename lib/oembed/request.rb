# encoding: utf-8
require 'net/http'
require 'oembed/uri'

module Oembed
  class Error < StandardError; end

  class Request
    attr_reader :uri
  
    def initialize(uri = nil)
      @uri = uri
    end

    def http
      @http ||= Net::HTTP.new(uri.host, uri.port).tap do |client|
        client.use_ssl = uri.https?
      end
    end
    
    def perform!
      http.get(uri.path)
    end
  end
end
