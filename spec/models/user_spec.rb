require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/models/user'

describe User do
  after do
    BaseModel.clear
  end

  it "should initialize a new user" do
    user = User.new(user_name: 'A')
    assert user.class, User
  end

  it "should save a user with corrrect params" do
    res1 = User.new(user_name: 'A').save
    expect(res1).must_equal(true)
  end

  it "should not save a duplicate user" do
    res1 = User.new(user_name: 'A').save
    expect(res1).must_equal(true)

    res2 = User.new(user_name: 'A').save
    expect(res2).must_equal(false)
  end

  it "should add recommended by for a new user" do
    user1 = User.new(user_name: 'A')
    user2 = User.new(user_name: 'B')

    user2.recommended_by(user1)

    assert_equal user2.recommended_by_user.id, user1.id
  end

  it "should raise and exception if user is recommended twice" do
    user1 = User.new(user_name: 'A')
    user2 = User.new(user_name: 'B')
    user3 = User.new(user_name: 'C')

    user2.recommended_by(user1)

    assert_raises 'User was already recommended by someone' do
      user2.recommended_by(user3)
    end
  end

  it "should add up points correctly for user" do
    user = User.new(user_name: 'A')

    assert_equal user.points, 0
    user.add_points(1)
    assert_equal user.points, 1

    user.add_points(0.5)
    assert_equal user.points, 1.5

    user.add_points(0.25)
    assert_equal user.points, 1.75
  end
end
