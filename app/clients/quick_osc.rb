class Clients::QuickOsc < Clients::Client
  def bind
    on "/.*" do |msg|
      puts "listening: #{msg.inspect}"
    end
  end
end
