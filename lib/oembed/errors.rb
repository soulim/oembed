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
end