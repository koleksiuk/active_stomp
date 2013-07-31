module ActiveStomp
  class Base
    def initialize(configuration = {})
      self.config = configuration

      self.client = ::Stomp::Client.new(config[:stomp])
      self.queue = config[:queue]       || '/queue/stomp'
      self.respond = config[:respond]   || 'client'
    end

    def start(&block)
      Signal.trap('INT') do
        destroy
      end

      listen(&block)

      client.join
    end

    def stop
      client.unsubscribe queue
      client.join
    end

    def destroy
      client.close
    end

    protected

    def listen(&block)
      client.subscribe queue, { ack: respond } do |message|
        reply = block.call(message.body)

        if respond == 'client'
          if reply == :ack
            client.acknowledge(message)
          else
            client.nack(message)
          end
        end
      end
    end

    attr_accessor :config, :client, :queue, :respond
    attr_reader :respond

    # param [String] value
    def respond=(value)
      value = :auto unless ['auto', 'client'].include? value

      @respond = value
    end
  end
end
