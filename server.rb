require "application"
require "osc-ruby/em_server"

port = (ARGF.argv[0] || 4000).to_i
@server = OSC::EMServer.new(port)
puts "Running OSC server on port #{port}. CTRL-C to stop..."

@server.add_method '/.*' do |msg|
  puts "#{msg.ip_address}:#{msg.ip_port} -- #{msg.address} -- #{msg.to_a}"
end

@server.run
