require 'spec_helper'

describe Oembed::XmlParser do
  let(:source) do
    %q(<?xml version="1.0" encoding="utf-8" standalone="yes"?>
       <oembed>
         <foo>text</foo>
         <bar>
           <baz>1</baz>
         </bar>
       </oembed>)
  end
  let(:result) { { 'foo' => 'text', 'bar' => { 'baz' => '1' } } }

  describe '.parse' do
    it 'should parse given source' do
      expect(Oembed::XmlParser.parse(source)).to eq(result)
    end

    context 'when there is an exception during parsing' do
      before do
        REXML::Document.stub(:new).and_raise(REXML::ParseException.new('error'))
      end

      it 'should raise Oembed::ParserError' do
        expect {
          Oembed::XmlParser.parse(source)
        }.to raise_error(Oembed::ParserError)
      end
    end
  end
end