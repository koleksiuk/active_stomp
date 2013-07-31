require 'spec_helper'
require 'json'

class Dummy
  def initialize(config)
    self.config = config
    self.receiver = ActiveStomp::Base.new(config)
  end

  def start
    receiver.start do |message|
      begin
        JSON.parse(message)
        :ack
      rescue
        :error
      end
    end
  end

  attr_accessor :config, :receiver
end

describe Dummy do
  let(:stomp_receiver) { double('stomp_receiver').as_null_object }

  let(:config) do
    { stomp: { hosts: { host: "localhost", port: 61613, user: '', pass: "", ssl: false } }, queue: '/queue/dummy' }
  end

  before do
    ActiveStomp::Base.stub(:new).and_return(stomp_receiver)
  end

  describe '#start' do
    let(:service) { described_class.new(config) }

    it 'should start Receivers::Stomp' do
      stomp_receiver.should_receive(:start)

      service.start
    end

    describe 'should handle received messages' do
      before do
        stomp_receiver.stub(:start)
        stomp_receiver.should_receive(:start).and_yield({a: 'b'}.to_json)
      end

      it 'and send received messages to JSON parser' do
        JSON.should_receive(:parse).with({a: 'b'}.to_json)

        service.start
      end
    end
  end
end

