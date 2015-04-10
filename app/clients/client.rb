class Clients::Client
  def initialize(game, ip, port)
    @game = game
    @client = OSC::Client.new(ip, port)  
    listen
  end

  def listen
    raise "Not implemented"
  end

  private

  def on(address)
    @game.add_method address do |msg|
      yield(msg)
    end
  end

  def deliver(path, *args)
    begin
      msg = OSC::Message.new(path, *args)
      @client.send(msg)
    rescue Errno::ECONNREFUSED
      false
    end
  end
end
