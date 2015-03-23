class Clients::QuickOsc < Clients::Client
  def listen
    on "/.*" do |msg|
      puts "listening: #{msg.inspect}"
    end
  end
end
