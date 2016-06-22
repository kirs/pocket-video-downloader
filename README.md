Fork of pocket-ruby
===========

Original URL: https://github.com/turadg/pocket-ruby

It can download N latest videos from [your Pocket library](https://getpocket.com/a/queue/).

## Prerequisites:

- You need to get your Pocket access token and hardcode it(run `demo-server.rb` and see the logs)
- You need to hardcode the destination folder
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

-------Original README below↓--------------------------------------------------------

pocket-ruby 
===========

Ruby API for v3 of the [Pocket API](http://getpocket.com/developer/docs/overview) (formerly Read It Later) 

# Usage

Just clone the repo here and refer to the demo-server.rb file for examples on how to interact with the Pocket API. 

```sh
	git clone
	cd pocket-ruby
	bundle install
	ruby demo-server.rb
```

Pocket-Ruby can be installed via the gem, ```gem install pocket-ruby```

Or via bundler, ```gem 'pocket-ruby'```

# For v0.0.5 and earlier

Using v0.0.5 and earlier may result in a ```require``` error. To fix this you may either update to a newer version of the gem or uninstall with ```gem uninstall pocket-ruby``` and try again using the method below:

Install via the gem, ```gem install pocket-ruby -v 0.0.5```

Or via bundler, ```gem 'pocket-ruby', '0.0.5', :require => 'pocket'```

Be sure to require the gem in your code with ```require 'pocket'``` not ```require 'pocket-ruby'```
