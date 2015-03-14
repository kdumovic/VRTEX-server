require "application"
require "osc-ruby/em_server"

port = (ARGF.argv[0] || 4000).to_i
@server = OSC::EMServer.new(port)
clients = Hash.new

puts "Running OSC server on port #{port}. CTRL-C to stop..."

@server.add_method '/.*' do |msg|
  puts "#{msg.ip_address}:#{msg.ip_port} -- #{msg.address} -- #{msg.to_a}"
end

@server.add_method '/register/.*' do |msg|
  full_ip = "#{msg.ip_address}:#{msg.ip_port}"
  if clients[full_ip].nil?
    puts "Registering #{klass} on #{full_ip}"
    client_type = msg.address.match("/register/(.*)")[1]
    klass = Kernel.const_get("Clients::#{client_type}")
    client = klass.new(@server, msg.ip_address, msg.ip_port)
    client.bind
    clients[full_ip] = client
  end
end
@server.run
