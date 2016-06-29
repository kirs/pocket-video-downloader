Fork of [pocket-ruby](https://github.com/turadg/pocket-ruby) and [inem/pocket-video-downloader](https://gitlab.com/inem/pocket-video-downloader)
===========

Downloads N latest videos from [your Pocket library](https://getpocket.com/a/queue/).

## My usage scenario:
Download last 5 videos to put them on my iPad before a long flight.

## Prerequisites:

- You have to run `ruby token-server.rb` which will get Pocket token and write it to `settings.yml`
- You need to hardcode the destination folder in `downloader.rb`
- You need to install [youtube-dl](https://github.com/rg3/youtube-dl).

Usage: `ruby downloader.rb`


## Limitations
- only supports Youtube
- regex for Youtube detection is very stupid
- limit of 100 items is hardcoded, so it won't work if you have mostly articles in you library
- No error handling

Your contributions are very welcome:

## What can be improved
- use separate yaml file to store access token
- accept arguments, like number of videos to download and simulation mode, and destination folder
- archive downloaded videos in Pocket
- support Vimeo

## More

Check out [pocket-ruby docs](https://github.com/turadg/pocket-ruby)
