# encoding: utf-8
require 'net/http'
require 'oembed/errors'
require 'uri'

module Oembed
  class Http
    attr_writer :parser

    def parser
      @parser ||= Oembed::Parser.new
    end

    def get(path, options = {})
      uri        = URI.parse(path)
      connection = establish_connection(uri.host, uri.port)
      response   = connection.get(uri.request_uri)

      case response
      when Net::HTTPRedirection
        follow_redirection(response['location'], options.fetch(:limit, 10))
      when Net::HTTPSuccess
        parser.parse(response.body, response.content_type)
      else
        raise Oembed::ResponseError.new(response), 'HTTP error during request'
      end
    end

    private

    def establish_connection(host, port)
      Net::HTTP.new(host, port).tap do |instance|
        instance.use_ssl = port == URI::HTTPS::DEFAULT_PORT
      end
    end

    def follow_redirection(location, limit)
      if limit > 0
        get(location, limit - 1)
      else
        raise Oembed::RedirectionTooDeepError, 'HTTP redirects too deep'
      end
    end
  end
end
