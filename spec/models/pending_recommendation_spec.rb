require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/models/pending_recommendation'

describe PendingRecommendation do
  after do
    BaseModel.clear
  end

  it "should initialize a new pending recommendation with corrrect params" do
    pending_recommendation = PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    )

    expect(pending_recommendation).must_be_kind_of(PendingRecommendation)
  end

  it "should save a pending recommendation with corrrect params" do
    res = PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    expect(res).must_equal(true)
  end

  it "should not save a duplicate pending recommendation" do
    res1 = PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save
    
    expect(res1).must_equal(true)

    res2 = PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    expect(res2).must_equal(false)
  end

  it "should find a pending recommendation with corrrect params" do
    res1 = PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    expect(res1).must_equal(true)

    pending_recommendation = PendingRecommendation.find_by('recommended_user_name', 'B')

    expect(pending_recommendation.recommended_by_user_name).must_equal('A')
    expect(pending_recommendation.recommended_user_name).must_equal('B')
  end

  it "should not return a pending recommendation with incorrect params" do
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'C'
    ).save

    pending_recommendation = PendingRecommendation.find_by('recommended_user_name', 'D')

    expect(pending_recommendation).must_be_nil
  end

  it "should destroy a pending recommendation with corrrect params" do
    PendingRecommendation.new(
      recommended_by_user_name: 'A',
      recommended_user_name: 'B'
    ).save

    pending_recommendation = PendingRecommendation.find_by('recommended_user_name', 'B')
    pending_recommendation.destroy

    res = PendingRecommendation.find_by('recommended_user_name', 'B')
    expect(res).must_be_nil
  end
end
