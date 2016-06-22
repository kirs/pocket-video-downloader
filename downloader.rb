# Project URL: https://gitlab.com/inem/pocket-video-downloader

# Uses https://github.com/turadg/pocket-ruby & 
#      https://github.com/rg3/youtube-dl

require "./lib/pocket-ruby.rb"

Pocket.configure do |config|
  config.consumer_key = '10188-3565cd04d1464e6d0e64b67f' # have no idea what is it
end

access_token = "your-access-token" # run ruby demo-server.rb, authorize, grab your access token in logs, and hardcode it here
download_n_videos = 5
where_to_store = "./Pocket/"

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

