require 'minitest/autorun'
require 'minitest/spec'
require_relative '../../src/parser/recommendations_input_parser'

describe RecommendationsInputParser do
  it "should parse the file correctly" do

    file_path = File.expand_path('../fixtures/recommendations_input.txt', __dir__)
    input_parser = FileParser.new(file_path: file_path)
    parsed_data = RecommendationsInputParser.new(input_parser: input_parser).call

    expect(parsed_data[0].date_time).must_equal('2018-06-12 09:41')
    expect(parsed_data[0].user).must_equal('A')
    expect(parsed_data[0].action).must_equal('recommends')
    expect(parsed_data[0].recommended_user).must_equal('B')

    expect(parsed_data[1].date_time).must_equal('2018-06-14 09:41')
    expect(parsed_data[1].user).must_equal('B')
    expect(parsed_data[1].action).must_equal('accepts')
    expect(parsed_data[1].recommended_user).must_be_nil
  end
end
