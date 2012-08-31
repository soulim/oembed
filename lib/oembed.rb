# encoding: utf-8
require 'oembed/request'
require 'oembed/version'

module Oembed
  def fetch(resource_url)
    request = Oembed::Request.new(self.endpoint_url, resource_url)

    begin
      request.perform
    rescue Oembed::Error
      {}
    end
  end
end
