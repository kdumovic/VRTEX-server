class Clients::QuickOsc < Clients::Client
  def listen
    on "/.*" do |msg|
      puts "listening: #{msg.inspect}"
    end

    on "/a" do |msg|
      current_stage.atob
    end

    on "/b" do |msg|
      current_stage.btof
    end
  end
end
