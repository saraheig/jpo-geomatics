require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  setup do
    @player = players(:one)
  end

  test 'validates pseudo presence' do
    pseudo = Player.new(pseudo: nil)
    assert_not pseudo.valid?
  end

  test 'validates pseudo uniqueness' do
    duplicate_pseudo = @player.dup
    assert_not duplicate_pseudo.valid?
  end
end
