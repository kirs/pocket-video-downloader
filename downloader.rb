require 'bundler/setup'
# Project URL: https://gitlab.com/inem/pocket-video-downloader

# Uses https://github.com/turadg/pocket-ruby &
#      https://github.com/rg3/youtube-dl

require "./lib/pocket-ruby.rb"

Pocket.configure do |config|
  config.consumer_key = '10188-3565cd04d1464e6d0e64b67f' # have no idea what is it
end

require 'yaml'
access_token = begin
  settings = YAML.load(File.read('settings.yml'))
  access_token = settings.fetch(:access_token)
rescue Errno::ENOENT
  puts "settings.yml does not exist. Please run demo-server to get the Pocket token"
  exit 1
rescue KeyError
  puts "settings.yml does not have access_token present. Please run demo-server to get the Pocket token"
  exit 1
end

download_n_videos = 10
where_to_store = "~/Movies/Pocket/"

client = Pocket.client(:access_token => access_token)

info = client.retrieve(:detailType => :complete, :count => 100)

info["list"].values.select{|item| item["given_url"] =~ /youtube\.com/ }.select{|item| item["has_video"] == "2"}.first(download_n_videos).each do |item|
	url   = item["given_url"]
	id    = item["item_id"]
	title = item["given_title"]

	puts id, url, title, ""
	`mkdir -p #{where_to_store}`
	`youtube-dl #{url} --recode-video mp4 --exec 'mv {} #{where_to_store}' -q`
	# -s - simulate
	# -q - quiet
end
