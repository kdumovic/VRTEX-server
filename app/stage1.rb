class Stage1
  include AASM

  def initialize(game)
    @game = game
  end

  def game
    @game
  end

  def enter_stage
    game.broadcast_stage(aasm.current_state)
  end

  aasm do
    state :initial, initial: true
    state :a, after_enter: :enter_stage
    state :b, after_enter: :enter_stage
    state :finished

    event :start do
      transitions from: :initial, to: :a
    end

    event :atob do
      transitions(
        from: :a,
        to: :b,
      )
    end

    event :btof do
      transitions(
        from: :b,
        to: :finished,
      )
      after do
        if game.stage1?
          game.stage1_finished
        else
          game.stage2_finished
        end
      end
    end
  end
end
