require 'spec_helper'
require 'fakeweb'

describe Oembed::Http do
  let(:parser) { double('Parser', parse: 'foo') }
  let(:uri)    { 'http://example.com/foo' }

  subject { Oembed::Http.new.tap { |http| http.parser = parser  } }

  before { FakeWeb.allow_net_connect = false }

  describe '#get' do
    context 'when response is successful' do
      before do
        FakeWeb.register_uri(:get, uri, body: 'OK', status: [200, 'OK'])
      end

      it 'should parse response body' do
        parser.should_receive(:parse)
        subject.get(uri)
      end

      it 'should return parsing result' do
        expect(subject.get(uri)).to eq(parser.parse)
      end
    end

    context 'when amount of redirects is above the limit' do
      before do
        FakeWeb.register_uri(:get, uri, body: 'Redirect', status: [301, 'Moved Permanently'])
      end

      it 'should raise TooManyRedirects exception' do
        expect {
          subject.get(uri, limit: 0)
        }.to raise_error(Oembed::RedirectionTooDeepError)
      end
    end

    context 'when response is HTTP error' do
      before do
        FakeWeb.register_uri(:get, uri, body: 'Internal Server Error', status: [500, 'Internal Server Error'])
      end

      it 'should raise HttpError exception' do
        expect { subject.get(uri) }.to raise_error(Oembed::ResponseError)
      end
    end
  end
end
