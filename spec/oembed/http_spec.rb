require 'fakeweb'
require 'oembed/http'

RSpec.describe Oembed::Http do
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
        expect(parser).to receive(:parse)
        subject.get(uri)
      end

      it 'should return parsing result' do
        expect(subject.get(uri)).to eq(parser.parse)
      end
    end

    context 'when response is a redirect, followed by a redirect' do
      let(:redirect_uri_one)    { 'http://example.com/redirect_one' }
      let(:redirect_uri_two)    { 'http://example.com/redirect_two' }

      before do
        FakeWeb.register_uri(:get, uri, body: 'Redirect', status: [301, 'Moved Permanently'], location: redirect_uri_one)
        FakeWeb.register_uri(:get, redirect_uri_one, body: 'Redirect', status: [301, 'Moved Permanently'], location: redirect_uri_two)
        FakeWeb.register_uri(:get, redirect_uri_two, body: 'OK', status: [200, 'OK'])
      end

      it 'should parse response body, eventually' do
        expect(parser).to receive(:parse)
        subject.get(uri)
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
