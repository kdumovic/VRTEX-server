require "application"
require "osc-ruby/em_server"

port = (ARGF.argv[0] || 4000).to_i
@server = OSC::EMServer.new(port)
clients = Hash.new

puts "Running OSC server on port #{port}. CTRL-C to stop..."

@server.add_method '/.*' do |msg|
  puts msg.inspect
  puts "#{msg.ip_address}:#{msg.ip_port} -- #{msg.address} -- #{msg.to_a}"
end

@server.add_method '/register/.*' do |msg|
  match_data = msg.address.match(/\/register\/(.*)\/(\d*)/)
  client_type = match_data[1]
  ip_port = match_data[2]
  full_ip = "#{msg.ip_address}:#{ip_port}"
  if clients[full_ip].nil?
    klass = Kernel.const_get("Clients::#{client_type}")
    puts "Registering #{klass} on #{full_ip}"
    client = klass.new(@server, msg.ip_address, ip_port)
    client.bind
    clients[full_ip] = client
  end
end
@server.run
