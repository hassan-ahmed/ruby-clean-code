require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/models/user'

describe User do
  describe "user model test" do
    it "should initialize a new user" do
      user = User.new
      assert user.is_a? User
    end

    it "should add recommended by for a new user" do
      user1 = User.new
      user2 = User.new

      user2.recommended_by(user: user1)

      assert_equal user2.recommended_by_user.id, user1.id
    end

    it "should raise and exception if user is recommended twice" do
      user1 = User.new
      user2 = User.new
      user3 = User.new

      user2.recommended_by(user: user1)

      assert_raises 'User was already recommended by someone' do
        user2.recommended_by(user: user3)
      end
    end

    it "should add correct points for level 1 recommendation" do
      user1 = User.new
      user2 = User.new

      user2.recommended_by(user: user1)

      assert_equal user1.points, 1
    end

    it "should add correct points for 'n' level 1 recommendations" do
      user1 = User.new
      user2 = User.new
      user3 = User.new

      user2.recommended_by(user: user1)
      user3.recommended_by(user: user1)

      assert_equal user1.points, 2
    end

    it "should calculate correct points for level 2 recommendations" do
      user1 = User.new
      user2 = User.new
      user3 = User.new

      user2.recommended_by(user: user1)
      user3.recommended_by(user: user2)

      assert_equal user1.points, 1.5
      assert_equal user2.points, 1
    end

    it "should calculate correct points for level 3 recommendations" do
      user1 = User.new
      user2 = User.new
      user3 = User.new
      user4 = User.new

      user2.recommended_by(user: user1)
      user3.recommended_by(user: user2)
      user4.recommended_by(user: user3)

      assert_equal user1.points, 1.75
      assert_equal user2.points, 1.5
      assert_equal user3.points, 1
    end

    it "should calculate correct points for complex recommendation heirarchy" do
      user1 = User.new
      user2 = User.new
      user3 = User.new
      user4 = User.new
      user5 = User.new

      user2.recommended_by(user: user1)
      user3.recommended_by(user: user2)
      user4.recommended_by(user: user2)
      user5.recommended_by(user: user3)

      assert_equal user1.points, 2.25

      assert_equal user2.points, 2.5
      assert_equal user3.points, 1

      assert_equal user4.points, 0
      assert_equal user5.points, 0
    end
  end
end
