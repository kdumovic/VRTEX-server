require "application"
require "yaml"
require "osc-ruby/em_server"

port = (ARGF.argv[0] || 4000).to_i
@server = OSC::EMServer.new(port)

config = YAML.load_file("./config.yml")
clients = {}

config["devices"].each do |device, ip_port|
  clients[device] = OSC::Client.new(
    config["devices"][device]["ip"],
    config["devices"][device]["port"],
  )
end

puts "Running OSC server on port #{port}. CTRL-C to stop..."
puts "Configured for the following clients:", clients.keys

clients.each do |name, client|
  @server.add_method "/#{name}/.*" do |msg|
    begin
      client.send(msg)
    rescue Errno::ECONNREFUSED
      puts "Failed to send msg to #{name}"
      false
    end
  end
end

@server.run
