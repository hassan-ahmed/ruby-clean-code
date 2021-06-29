require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/actions/process_recommendation_file'

describe ProcessRecommendationFile do
  after do
    BaseModel.clear
  end

  it "should process the recommendation and return the input as expected" do
    file_path = File.expand_path('../fixtures/recommendations_input.txt', __dir__)
    res = ProcessRecommendationFile.call(file_path: file_path)

    expected_result = {
      'A' => 1.75, 'B' => 1.5, 'C' => 1, 'D' => 0
    }

    expect(res).must_equal(expected_result)
  end
end
