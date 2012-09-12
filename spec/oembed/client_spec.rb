require 'spec_helper'

describe Oembed::Client do
  let(:http)         { double('Http', get: 'foo') }
  let(:endpoint_uri) { 'http://example.com/oembed' }
  let(:resource_uri) { 'http://example.com/foo' }

  subject do
    double('OembedClient',
      http: http,
      endpoint_uri: endpoint_uri
    ).extend(Oembed::Client)
  end

  describe '#fetch' do
    it 'should fetch the date using self.fetch!' do
      subject.should_receive(:fetch!)
      subject.fetch(resource_uri)
    end

    context 'when there is an error during request' do
      before { http.stub(:get).and_raise(Oembed::Error) }

      it 'should return nil' do
        expect(subject.fetch(resource_uri)).to be_nil
      end
    end
  end

  describe '#fetch!' do
    it 'should prepare request URI' do
      Oembed::Uri.should_receive(:new).with(endpoint_uri, resource_uri)
      subject.fetch!(resource_uri)
    end

    it 'should get oEmbed data via HTTP client' do
      http.should_receive(:get)
      subject.fetch!(resource_uri)
    end
  end
end
