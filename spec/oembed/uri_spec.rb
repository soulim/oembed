require 'oembed/uri'

RSpec.describe Oembed::Uri do
  let(:endpoint_uri) { 'http://example.com/oembed' }
  let(:resource_uri) { 'http://example.com/foo' }

  subject { Oembed::Uri.new(endpoint_uri, resource_uri) }

  it 'should accept optional params' do
    uri = Oembed::Uri.new(endpoint_uri, resource_uri, width: 100)

    query_string = URI.parse(uri.to_s).query
    query_data   = URI.decode_www_form(query_string)
    query        = Hash[query_data]

    expect(query['width']).to eq('100')
  end

  describe '#to_s' do
    it 'should return oEmbed URI string' do
      expect(subject.to_s).to eq('http://example.com/oembed?url=http%3A%2F%2Fexample.com%2Ffoo')
    end
  end
end
