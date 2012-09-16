# encoding: utf-8

module Oembed
  module Client
    attr_writer :http

    def endpoint_uri
      raise NotImplementedError
    end

    def http
      @http ||= Oembed::Http.new
    end

    def fetch(resource_uri, params = {})
      begin
        fetch!(resource_uri, params)
      rescue Oembed::Error
        nil
      end
    end

    def fetch!(resource_uri, params = {})
      uri = Oembed::Uri.new(endpoint_uri, resource_uri, params)
      http.get(uri.to_s)
    end
  end
end
