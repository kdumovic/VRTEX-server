class Clients::Client
  include Listener

  def initialize(server, ip, port)
    @server = server
    @client = OSC::Client.new(ip, port)  
  end

  def send(path, *args)
    begin
      msg = OSC::Message.new(path, *args)
      @client.send(msg)
    rescue Errno::ECONNREFUSED
      false
    end
  end
end
