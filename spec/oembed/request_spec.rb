require 'spec_helper'
require 'oembed/request'

describe Oembed::Request do
  let(:uri) do
    double('URI',
      :host     => 'example.com',
      :port     => 80,
      :path     => '/foo',
      :'https?' => false)
  end
  let(:http_client) { double('HTTPClient', :get => 'foo') }
  
  subject { Oembed::Request.new(uri) }

  describe '#perform!' do
    before { subject.stub(:http => http_client) }
    
    it 'should name GET request' do
      http_client.should_receive(:get).with(uri.path)
      subject.perform!
    end
    
    it 'should return oEmbed response' do
      expect(subject.perform!).to be_kind_of(Oembed::Response)
    end
  end
end
