require 'oembed/parser'

RSpec.describe Oembed::Parser do
  let(:body)      { { 'foo' => 'bar', 'baz' => "1" } }
  let(:json_body) { '{"foo":"bar","baz":"1"}' }
  let(:xml_body)  do
    %q(<?xml version="1.0" encoding="utf-8" standalone="yes"?>
       <oembed>
         <foo>bar</foo>
         <baz>1</baz>
       </oembed>)
  end

  describe '#parse' do
    context 'when content type is JSON' do
      it 'should return parsed body' do
        expect(subject.parse(json_body, 'application/json')).to eq(body)
      end
    end

    context 'when content type is XML' do
      it 'should return parsed body' do
        expect(subject.parse(xml_body, 'text/xml')).to eq(body)
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
