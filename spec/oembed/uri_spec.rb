require 'spec_helper'
require 'oembed/uri'

describe Oembed::Uri do
  subject { Oembed::Uri.new(uri_string) }
  
  describe '#https?' do
    context 'if it uses HTTPS protocol' do
      let(:uri_string) { 'https://example.com/' }

      it 'should return true' do
        expect(subject.https?).to be_true
      end
    end

    context 'if it uses HTTP protocol' do
      let(:uri_string) { 'http://example.com/' }

      it 'should return false' do
        expect(subject.https?).to be_false
      end
    end
  end

  describe '#path' do
    let(:uri_string) { 'http://example.com/foo?bar=baz' }

    it 'should return the full path of URI with query parameters' do
      expect(subject.path).to eq('/foo?bar=baz')
    end
  end
end
