require 'oembed/client'

RSpec.describe Oembed::Client do
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
    it 'should accept optional params' do
      expect {subject.fetch(resource_uri, width: 100) }.not_to raise_error
    end

    it 'should fetch the date using self.fetch!' do
      expect(subject).to receive(:fetch!)
      subject.fetch(resource_uri)
    end

    context 'when there is an error during request' do
      before { allow(http).to receive(:get).and_raise(Oembed::Error) }

      it 'should return nil' do
        expect(subject.fetch(resource_uri)).to be_nil
      end
    end
  end

  describe '#fetch!' do
    it 'should accept optional params' do
      expect {subject.fetch(resource_uri, width: 100) }.not_to raise_error
    end

    it 'should prepare request URI' do
      expect(Oembed::Uri).to receive(:new).with(
        endpoint_uri,
        resource_uri,
        width: 100
      )
      subject.fetch!(resource_uri, width: 100)
    end

    it 'should get oEmbed data via HTTP client' do
      expect(http).to receive(:get)
      subject.fetch!(resource_uri)
    end
  end
end
