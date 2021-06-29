require 'sinatra'
require 'json'
include FileUtils::Verbose
require_relative './src/actions/process_recommendation_file'

get '/' do
  send_file './src/views/index.html'
end

post '/' do
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  uploaded_file_path = "tmp/#{filename}"

  cp(tempfile.path, uploaded_file_path)

  res = ProcessRecommendationFile.call(
    file_path: uploaded_file_path
  )

  content_type :json
  res.to_json
end
