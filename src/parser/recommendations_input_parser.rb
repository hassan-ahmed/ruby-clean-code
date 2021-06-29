require_relative '../request_models/recommendation_request_model'

class RecommendationsInputParser
  ROW_PARSER_REGEX = /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}) (\w) (recommends|accepts)\s?(\w)?/

  def initialize(input_parser:)
    @input_parser = input_parser
  end

  def call
    data = @input_parser.data
    parse_data(data)
  end

  private

  def parse_data(data)
    data_rows = rows(data)
    data_rows.map do |row|
      data = row.scan(ROW_PARSER_REGEX).flatten
      build_response(data)
    end
  end

  def rows(data)
    data.split(/\n|\r/).reject { |str| str.empty? }
  end

  def build_response(data)
    RecommendationRequestModel.new({
      date_time: data[0],
      user: data[1],
      action: data[2],
      recommended_user: data[3]
    })
  end
end
