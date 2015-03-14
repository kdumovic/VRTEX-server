class Clients::QuickOscLeapDemo < Clients::Client
  def bind
    @server.add_method '/hand' do |msg|
      @qc.send("/tog1/value", msg.to_a.first)
    end
    @server.add_method '/leftradius' do |msg|
      @qc.send("/sb1/value", msg.to_a.first.to_i)
    end
    @server.add_method '/rightradius' do |msg|
      @qc.send("/sb2/value", msg.to_a.first.to_i)
    end
  end

  @qc.send("/sb1/range", 40, 200)
  @qc.send("/sb2/range", 40, 200)
end
