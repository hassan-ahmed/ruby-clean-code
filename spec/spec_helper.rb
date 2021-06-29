require 'minitest/autorun'
require 'minitest/spec'
require_relative '../src/models/base_model'

describe 'Helper' do
  after do
    BaseModel.clear
  end
end
