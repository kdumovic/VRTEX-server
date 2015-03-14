class Clients::QuickOsc < Clients::Client
  def bind
    @server.add_method "/.*" do |msg|
      puts "listening: #{msg.inspect}"
    end
  end
end
