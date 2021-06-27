require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/recommendation_interactor'

describe RecommendationInteractor do
  it "should initialize recommendation interactor with corrrect inputs" do
    user1 = User.new
    user2 = User.new

    recommendation = RecommendationInteractor.new(
      recommended_user: user1,
      recommended_by_user: user2
    )

    expect(recommendation).must_be_kind_of(RecommendationInteractor)
  end

  it "should correctly link recommended user" do
    recommended_by_user = User.new
    recommended_user = User.new

    RecommendationInteractor.new(
      recommended_user: recommended_user,
      recommended_by_user: recommended_by_user
    ).call

    expect(recommended_user.recommended_by_user).must_be_same_as(recommended_by_user)
  end

  it "should calculate correct points for level 0 recommendation" do
    recommended_by_user = User.new
    recommended_user = User.new

    expect(recommended_by_user.points).must_equal(0)

    RecommendationInteractor.new(
      recommended_user: recommended_user,
      recommended_by_user: recommended_by_user
    ).call
    
    expect(recommended_by_user.points).must_equal(1)
  end

  it "should calculate correct points for multiple level 0 recommendations" do
    recommended_by_user = User.new
    recommended_user1 = User.new
    recommended_user2 = User.new

    expect(recommended_by_user.points).must_equal(0)

    RecommendationInteractor.new(
      recommended_user: recommended_user1,
      recommended_by_user: recommended_by_user
    ).call
    
    expect(recommended_by_user.points).must_equal(1)

    RecommendationInteractor.new(
      recommended_user: recommended_user2,
      recommended_by_user: recommended_by_user
    ).call

    expect(recommended_by_user.points).must_equal(2)
  end

  it "should calculate correct points for level 1 recommendation" do
    user1 = User.new
    user2 = User.new
    user3 = User.new

    expect(user1.points).must_equal(0)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    RecommendationInteractor.new(
      recommended_by_user: user1,
      recommended_user: user2
    ).call

    expect(user1.points).must_equal(1)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    RecommendationInteractor.new(
      recommended_by_user: user2,
      recommended_user: user3
    ).call

    expect(user1.points).must_equal(1.5)
    expect(user2.points).must_equal(1)
    expect(user3.points).must_equal(0)
  end
end
