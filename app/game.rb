class Game
  include AASM

  aasm do
    state :waiting, initial: true
    state :stage1
    state :stage2
    state :finished, after_enter: :broadcast_stage

    event :start do
      transitions from: :waiting, to: :stage1
      after do
        @stage1.start
      end
    end

    event :stage1_finished do
      transitions(
        from: :stage1,
        to: :stage2,
        guard: :stage1_finished?,
      )
      after do
        @stage2.start
      end
    end

    event :stage2_finished do
      transitions(
        from: :stage2,
        to: :finished,
        guard: :stage2_finished?,
      )
    end
  end

  def initialize(server)
    @server = server
    @clients = Hash.new
    @stage1 = Stage1.new(self)
    @stage2 = Stage1.new(self)
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
    @clients.values.each do |c|
      yield(c)
    end
  end

  def add_method(address)
    @server.add_method address do |msg|
      yield(msg)
    end
  end

  def current_stage
    if stage1?
      @stage1
    else
      @stage2
    end
  end

  def broadcast_stage(substage = nil)
    each do |client|
      client.deliver("/stage/#{aasm.current_state}.#{substage}")
    end
  end

  def stage1_finished?
    @stage1.finished?
  end

  def stage2_finished?
    @stage2.finished?
  end
end
