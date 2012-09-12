# encoding: utf-8

module Oembed
  class Parser
    SUPPORTED_FORMATS = {
      'text/xml'               => :xml,
      'application/json'       => :json,
    }

    def parse(body, content_type)
      format = SUPPORTED_FORMATS[content_type]

      if format
        send(format, body)
      else
        raise Oembed::NotSupportedFormatError,
            "parser does not support #{format.inspect} format"
      end
    end

    private

    def json(body)
      begin
        JSON.parse(body)
      rescue JSON::JSONError => e
        raise Oembed::ParserError.new(e), 'JSON parser error'
      end
    end

    def xml(body)
      raise NotImplementedError, 'XML parser is not implemented'
    end
  end
end
