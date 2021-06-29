require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/user_scores_interactor'
require_relative '../../src/models/base_model'

describe UserScoresInteractor do
  after do
    BaseModel.clear
  end

  it "should initialize recommendation points interactor with corrrect inputs" do
    user_scores_interactor = UserScoresInteractor.new()

    expect(user_scores_interactor).must_be_kind_of(UserScoresInteractor)
  end

  it "should return an empty array if no user is present" do
    res = UserScoresInteractor.new().call

    expect(res).must_equal({})
  end

  it "should return corrrect response for saved users" do
    User.new(user_name: 'A', points: 2).save
    User.new(user_name: 'B', points: 1.5).save
    User.new(user_name: 'C', points: 0.5).save
    res = UserScoresInteractor.new().call

    expected_result = {
      'A' => 2,
      'B' => 1.5,
      'C' => 0.5
    }
    expect(res).must_equal(expected_result)
  end
end
