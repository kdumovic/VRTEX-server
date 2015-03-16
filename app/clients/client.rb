class Clients::Client
  def initialize(server, ip, port)
    @server = server
    @client = OSC::Client.new(ip, port)  
  end

  private

  def on(address)
    @server.add_method address do
      yield
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
