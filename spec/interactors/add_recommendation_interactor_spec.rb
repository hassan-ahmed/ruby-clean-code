require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/add_recommendation_interactor'
require_relative '../../src/models/base_model'

describe AddRecommendationInteractor do
  after do
    BaseModel.clear
  end

  it "should initialize recommendation interactor with corrrect inputs" do
    recommendation = AddRecommendationInteractor.new(
      recommended_user_name: 'A',
      recommended_by_user_name: 'B',
      date_time: '2018-06-23 09:41'
    )

    expect(recommendation).must_be_kind_of(AddRecommendationInteractor)
  end
end
