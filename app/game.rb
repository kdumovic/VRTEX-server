class Game
  def initialize(server)
    @server = server
    @clients = Hash.new
  end

  def include?(ip_port)
    !@clients[ip_port].nil?
  end

  def [](ip_port)
    @clients[ip_port]
  end

  def []=(ip_port, client)
    @clients[ip_port] = client
  end

  def each
    @clients.each do |c|
      yield(c)
    end
  end

  def add_method(address)
    @server.add_method address do |msg|
      yield(msg)
    end
  end
end
