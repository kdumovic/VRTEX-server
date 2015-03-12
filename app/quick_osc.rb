class QuickOsc
  def initialize(addr, port)
    @client = OSC::Client.new(addr, port)  
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
