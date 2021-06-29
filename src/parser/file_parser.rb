require_relative './base_parser'

class FileParser < BaseParser
  def initialize(file_path:)
    @file_path = file_path
  end

  def data
    File.read(@file_path)
  end
end
