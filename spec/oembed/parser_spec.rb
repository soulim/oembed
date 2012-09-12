require 'spec_helper'

describe Oembed::Parser do
  let(:body)      { { 'foo' => 'bar', 'baz' => 1 } }
  let(:json_body) { '{"foo":"bar","baz":1}' }
  let(:xml_body)  { 'xml-body' }

  describe '#parse' do
    context 'when content type is JSON' do
      it 'should return parsed body' do
        expect(subject.parse(json_body, 'application/json')).to eq(body)
      end
    end

    context 'when content type is XML' do
      it 'should raise NotImplementedError' do
        expect {
          subject.parse(xml_body, 'text/xml')
        }.to raise_error(NotImplementedError)
      end
    end

    context 'when content type is not supported' do
      it 'should raise Oembed::NotSupportedFormatError' do
        expect {
          subject.parse(json_body, 'wrong/type')
        }.to raise_error(Oembed::NotSupportedFormatError)
      end
    end
  end
end
