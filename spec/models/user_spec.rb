require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/models/user'

describe User do
  it "should initialize a new user" do
    user = User.new
    assert user.class, User
  end

  it "should add recommended by for a new user" do
    user1 = User.new
    user2 = User.new

    user2.recommended_by(user1)

    assert_equal user2.recommended_by_user.id, user1.id
  end

  it "should raise and exception if user is recommended twice" do
    user1 = User.new
    user2 = User.new
    user3 = User.new

    user2.recommended_by(user1)

    assert_raises 'User was already recommended by someone' do
      user2.recommended_by(user3)
    end
  end

  it "should add up points correctly for user" do
    user = User.new

    assert_equal user.points, 0
    user.add_points(1)
    assert_equal user.points, 1

    user.add_points(0.5)
    assert_equal user.points, 1.5

    user.add_points(0.25)
    assert_equal user.points, 1.75
  end
end
