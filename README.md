# ActiveStomp

ActiveStomp allows to abstract the Stomp protocol

## Installation

Add this line to your application's Gemfile:

    gem 'active_stomp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_stomp

## Usage

Create an instance of ActiveStomp::Base with hash config and then just start it with block

Config options:
* :stomp [required]
https://github.com/stompgem/stomp#hash-login-example-usage-this-is-the-recommended-login-technique

* :queue [optional]
Queue that receiver needs to subscribe (default to 'queue/stomp')

* :respond [optional
How client should respond to messages. Default - 'client'. Other options: auto.

```ruby
config =  { stomp: { hosts: { host: "localhost", port: 61613, user: '', pass: "", ssl: false } }, queue: '/queue/dummy' }

receiver = ActiveStomp::Base.new(config)

receiver.start do |message|
  begin
    # do something here with received message
    # e.g. parse
    msg = JSON.parse(message)
    save!(msg)

    :ack # notify that everything is ok
  rescue
    :error # something went wrong!
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT
