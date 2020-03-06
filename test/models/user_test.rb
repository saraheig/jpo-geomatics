require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'validates pseudo presence' do
    pseudo = User.new(pseudo: nil)
    assert_not pseudo.valid?
  end

  test 'validates pseudo uniqueness' do
    duplicate_pseudo = @user.dup
    assert_not duplicate_pseudo.valid?
  end

  test 'validates password presence' do
    password = User.new(password: nil)
    assert_not password.valid?
  end
end
