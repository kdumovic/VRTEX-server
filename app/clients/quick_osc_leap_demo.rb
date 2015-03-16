class Clients::QuickOscLeapDemo < Clients::Client
  def bind
    on '/hand' do |msg|
      deliver("/tog1/value", msg.to_a.first)
    end
    on '/leftradius' do |msg|
      deliver("/sb1/value", msg.to_a.first)
    end
    on '/rightradius' do |msg|
      deliver("/sb2/value", msg.to_a.first.to_i)
    end

    deliver("/sb1/range", 40, 200)
    deliver("/sb2/range", 40, 200)
  end
end
