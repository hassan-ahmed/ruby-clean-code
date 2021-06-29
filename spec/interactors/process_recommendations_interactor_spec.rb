require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/interactors/process_recommendations_interactor'
require_relative '../../src/models/base_model'

describe ProcessRecommendationsInteractor do
  after do
    BaseModel.clear
  end

  it "should process the input data correctly" do
    file_path = File.expand_path('../fixtures/recommendations_input.txt', __dir__)
    file_parser = FileParser.new(file_path: file_path)

    recommendations_input_parser = RecommendationsInputParser.new(
      input_parser: file_parser
    )

    ProcessRecommendationsInteractor.new(
      recommendations_input_parser: recommendations_input_parser
    ).call

    user1 = User.find_by('user_name', 'A')
    user2 = User.find_by('user_name', 'B')
    user3 = User.find_by('user_name', 'C')
    user4 = User.find_by('user_name', 'D')

    expect(user1.user_name).must_equal('A')
    expect(user1.points).must_equal(1.75)
    expect(user1.recommended_by_user).must_be_nil

    expect(user2.user_name).must_equal('B')
    expect(user2.points).must_equal(1.5)
    expect(user2.recommended_by_user).must_be_same_as(user1)

    expect(user3.user_name).must_equal('C')
    expect(user3.points).must_equal(1)
    expect(user3.recommended_by_user).must_be_same_as(user2)

    expect(user4.user_name).must_equal('D')
    expect(user4.points).must_equal(0)
    expect(user4.recommended_by_user).must_be_same_as(user3)
  end
end
