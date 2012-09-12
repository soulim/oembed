require 'spec_helper'

describe Oembed::Uri do
  let(:endpoint_uri) { 'http://example.com/oembed' }
  let(:resource_uri) { 'http://example.com/foo' }

  subject { Oembed::Uri.new(endpoint_uri, resource_uri) }

  describe '#to_s' do
    it 'should return oEmbed URI string' do
      expect(subject.to_s).to eq('http://example.com/oembed?url=http%3A%2F%2Fexample.com%2Ffoo')
    end
  end
end
