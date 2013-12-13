require 'sinatra'
require 'httparty'

set :root, File.dirname(__FILE__)
set :port, 3000
set :bind, '10.10.200.85'

get '/' do
  "Hello GemServer!"
end

get '/*.*' do |path, ext|
  file = "#{path}.#{ext}"
  if ext == 'html'
    path
  else
    if not File.exists?(file)
	  File.open(file, "wb"){|f| f.write HTTParty.get("http://ruby.taobao.org/#{file}").parsed_response }	
	  logger.info("Downloaded: #{file}")
	end
    send_file file
  end
end

run Sinatra::Application.run!