require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/accept_recommendation_interactor'
require_relative '../../src/models/base_model'

describe AcceptRecommendationInteractor do
  after do
    BaseModel.clear
  end

  it "should initialize accept recommendation interactor with corrrect inputs" do
    accept_recommendation_interactor = AcceptRecommendationInteractor.new(
      user_name: 'A'
    )

    expect(accept_recommendation_interactor).must_be_kind_of(AcceptRecommendationInteractor)
  end

  it "should accept a correct recommendation" do
    User.new(user_name: 'A').save
    User.new(user_name: 'B').save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    res = AcceptRecommendationInteractor.new(
      user_name: 'B'
    ).call

    expect(res).must_equal(true)

    recommendation = PendingRecommendation.find_by('recommended_user_name', 'B')

    expect(recommendation).must_be_nil
  end

  it "should calculate correct points for level 0 recommendation" do
    User.new(user_name: 'A').save
    User.new(user_name: 'B').save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    recommended_by_user = User.find_by('user_name', 'A')
    expect(recommended_by_user.points).must_equal(0)

    AcceptRecommendationInteractor.new(
      user_name: 'B'
    ).call

    expect(recommended_by_user.points).must_equal(1)
  end

  it "should calculate correct points for multiple level 0 recommendations" do
    User.new(user_name: 'A').save
    User.new(user_name: 'B').save
    User.new(user_name: 'C').save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'C'
    ).save

    user1 = User.find_by('user_name', 'A')
    user2 = User.find_by('user_name', 'B')
    user3 = User.find_by('user_name', 'C')

    expect(user1.points).must_equal(0)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    AcceptRecommendationInteractor.new(
      user_name: 'B'
    ).call

    expect(user1.points).must_equal(1)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    AcceptRecommendationInteractor.new(
      user_name: 'C'
    ).call

    expect(user1.points).must_equal(2)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)
  end

  it "should calculate correct points for level 1 recommendation" do
    User.new(user_name: 'A').save
    User.new(user_name: 'B').save
    User.new(user_name: 'C').save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save
    PendingRecommendation.new(
      recommended_by_user_name: 'B',
      recommended_user_name: 'C'
    ).save

    user1 = User.find_by('user_name', 'A')
    user2 = User.find_by('user_name', 'B')
    user3 = User.find_by('user_name', 'C')

    expect(user1.points).must_equal(0)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    AcceptRecommendationInteractor.new(
      user_name: 'B'
    ).call

    expect(user1.points).must_equal(1)
    expect(user2.points).must_equal(0)
    expect(user3.points).must_equal(0)

    AcceptRecommendationInteractor.new(
      user_name: 'C'
    ).call

    expect(user1.points).must_equal(1.5)
    expect(user2.points).must_equal(1)
    expect(user3.points).must_equal(0)
  end
end
