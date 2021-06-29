require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/recommendation_points_interactor'
require_relative '../../src/models/base_model'

describe RecommendationPointsInteractor do
  after do
    BaseModel.clear
  end

  it "should initialize recommendation points interactor with corrrect inputs" do
    user = User.new

    recommendation = RecommendationPointsInteractor.new(
      user: user
    )

    expect(recommendation).must_be_kind_of(RecommendationPointsInteractor)
  end

  it "should add correct points to a user for recommendation" do
    user = User.new

    expect(user.points).must_equal(0)

    RecommendationPointsInteractor.new(
      user: user
    ).call

    expect(user.points).must_equal(1)
  end

  it "should calculate correct points for level 0 recommendation" do
    user1 = User.new
    user2 = User.new

    expect(user1.points).must_equal(0)
    expect(user2.points).must_equal(0)

    user2.recommended_by(user1)

    RecommendationPointsInteractor.new(
      user: user2
    ).call

    expect(user2.points).must_equal(1)
    expect(user1.points).must_equal(0.5)
  end

  it "should calculate correct points for level 1 recommendation" do
    user1 = User.new
    user2 = User.new
    user3 = User.new

    expect(user1.points).must_equal(0)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    user2.recommended_by(user1)

    RecommendationPointsInteractor.new(
      user: user2
    ).call
    
    expect(user1.points).must_equal(0.5)
    expect(user2.points).must_equal(1)
    expect(user3.points).must_equal(0)

    user3.recommended_by(user2)

    RecommendationPointsInteractor.new(
      user: user3
    ).call

    expect(user1.points).must_equal(0.75)
    expect(user2.points).must_equal(1.5)
    expect(user3.points).must_equal(1)
  end
end
