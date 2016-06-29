require 'bundler/setup'
require "sinatra"

require "./lib/pocket-ruby.rb"

enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

Pocket.configure do |config|
  config.consumer_key = '10188-3565cd04d1464e6d0e64b67f'
end

get '/reset' do
  puts "GET /reset"
  session.clear
  redirect '/'
end

get "/" do
  puts "GET /"
  puts "session: #{session}"

  if session[:access_token]
    '
<h1>Your token is now saved to settings.yml. You may now run downloader.rb.</h1>
<a href="/retrieve">Test (retrieve single Pocket item)</a>
<a href="/reset">Reset session</a>
    '
  else
    '<a href="/oauth/connect">Connect with Pocket</a>'
  end
end

get "/oauth/connect" do
  puts "OAUTH CONNECT"
  session[:code] = Pocket.get_code(:redirect_uri => CALLBACK_URL)
  new_url = Pocket.authorize_url(:code => session[:code], :redirect_uri => CALLBACK_URL)
  puts "new_url: #{new_url}"
  puts "session: #{session}"
  redirect new_url
end

get "/oauth/callback" do
  puts "OAUTH CALLBACK"
  puts "request.url: #{request.url}"
  puts "request.body: #{request.body.read}"
  result = Pocket.get_result(session[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = result['access_token']

  require 'yaml'
  File.open("settings.yml", "w") do |f|
    f.write(YAML.dump({
      access_token: result.fetch('access_token'),
      username: result.fetch('username'),
    }))
  end

  redirect "/"
end

get '/add' do
  client = Pocket.client(:access_token => session[:access_token])
  info = client.add :url => 'http://getpocket.com'
  "<pre>#{info}</pre>"
end

get "/retrieve" do
  client = Pocket.client(:access_token => session[:access_token])
  info = client.retrieve(:detailType => :complete, :count => 1)

  # html = "<h1>#{user.username}'s recent photos</h1>"
  # for media_item in client.user_recent_media
  #   html << "<img src='#{media_item.images.thumbnail.url}'>"
  # end
  # html
  "<pre>#{info}</pre>"
end
