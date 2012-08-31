require 'spec_helper'
require 'oembed'

describe Oembed do
  let(:endpoint_url) { 'http://example.com/oembed' }
  let(:resource_url) { 'http://example.com/resource/url' }

  subject do
    double('DummyClient', endpoint_url: endpoint_url).extend(Oembed)
  end

  describe '#fetch' do
    let(:request) { double('Request', perform: { foo: 'bar' }) }

    before { Oembed::Request.stub(new: request) }

    it 'should initialize a new oEmbed request' do
      Oembed::Request.should_receive(:new).with(endpoint_url, resource_url)
      subject.fetch(resource_url)
    end

    it 'should perform oEmbed request' do
      request.should_receive(:perform)
      subject.fetch(resource_url)
    end

    it 'should return result of request' do
      expect(subject.fetch(resource_url)).to eq(request.perform)
    end

    context 'if request was not successful' do
      before { request.should_receive(:perform).and_raise(Oembed::Error) }

      it 'should return empty hash' do
        expect(subject.fetch(resource_url)).to eq({})
      end
    end
  end
end
