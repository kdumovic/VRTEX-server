class QuickOsc
  def initialize(addr, port)
    @client = OSC::Client.new(addr, port)  
  end

  def send(path, data)
    @client.send(OSC::Message.new(path, data)) 
  end
end
