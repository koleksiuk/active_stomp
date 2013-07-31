require 'spec_helper'

describe ActiveStomp::Base do
  let(:config) do
   { stomp: { hosts: { host: "localhost", port: 61613, user: '', pass: "", ssl: false } }, queue: '/queue/dummy' }
  end

  let(:stomp_client) { double('stomp_client').as_null_object }

  before do
    Stomp::Client.stub(:new).with(config[:stomp]).and_return stomp_client
  end

  describe '.initialize' do
    it 'should create new Stomp::Base instance' do
      described_class.should_receive(:new).with(config[:stomp])

      described_class.new(config[:stomp])
    end
  end

  describe '#start' do
    let!(:client) { described_class.new(config) }

    it 'should subscribe to stomp protocol' do
      stomp_client.should_receive(:subscribe).with('/queue/dummy', { ack: 'client' })

      client.start {|msg| msg }
    end
  end

  describe '#destroy' do
    let!(:client) { described_class.new(config) }

    it 'should send #close message to client' do
      stomp_client.should_receive(:close)
      client.destroy
    end
  end
end


