# oembed gem
[![Build Status](http://img.shields.io/travis/soulim/oembed.svg?style=flat)](http://travis-ci.org/soulim/oembed)  [![Code Climate](http://img.shields.io/codeclimate/github/soulim/oembed.svg?style=flat)](https://codeclimate.com/github/soulim/oembed)

[**oEmbed**](http://oembed.com/) is a format for allowing an embedded representation of a URL on third
party sites. The simple API allows a website to display embedded content
(such as photos or videos) when a user posts a link to that resource, without
having to parse the resource directly.

**oembed gem** is a simple to use and slim (~150 LOC) library to work with oEmbed format. It has no external dependencies at runtime. All you need to have is Ruby itself.

The library shares a behaviour of oEmbed client with any Ruby object. Just `include Oembed::Client` into that object and you are good to go.

**oembed gem** is provider agnostic. It has no pre-configured providers.
You can build a client for any oEmbed provider of the world :)

## Installation

Add this line to your application's Gemfile:

    gem 'oembed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oembed

## Usage

You have to do a few things to build an oEmbed client with `oembed` gem.

- `include Oembed::Client` into your object,
- add instance method `#endpoint_uri` to that object. This method has to return
  a string with URI of oEmbed endpoint.

Lets start with a simple example. It will be a client for the awesome
[Speaker Deck](http://speakerdeck.com). Note that we call the service class NameApi - this is to avoid clashing with gems (such as twitter) that may have classes named after the service.

```ruby
require 'oembed'

class SpeakerDeckApi
  include Oembed::Client

  # Read more about endpoint on https://speakerdeck.com/faq#oembed
  def endpoint_uri
    'http://speakerdeck.com/oembed.json'
  end
end
```

That's it. Now you can use a method `#fetch` to get data from oEmbed enpoint of Speaker Deck.

```ruby
client = SpeakerDeckApi.new
client.fetch('https://speakerdeck.com/u/soulim/p/rails')
```

The method `#fetch` will return a hash with oEmded data.

```ruby
{
  "type" => "rich",
  "version" => 1.0,
  "provider_name" => "Speaker Deck",
  "provider_url" => "https://speakerdeck.com/",
  "title" => "Локализация приложения на базе Rails. Личный опыт и советы",
  "author_name" => "Alex Soulim",
  "author_url" => "https://speakerdeck.com/u/soulim",
  "html" => "<iframe style=\"border:0; padding:0; margin:0; background:transparent;\" mozallowfullscreen=\"true\" webkitallowfullscreen=\"true\" frameBorder=\"0\" allowTransparency=\"true\" id=\"presentation_frame_4fd3874cebb4b2001f0277e5\" src=\"//speakerdeck.com/embed/4fd3874cebb4b2001f0277e5\" width=\"710\" height=\"596\"></iframe>\n",
  "width" => 710,
  "height" => 596
}
```

`oembed` gem supports JSON and XML response formats. Here is an example of
client for XML endpoint.

```ruby
require 'oembed'

class FlickrApi
  include Oembed::Client

  def endpoint_uri
    'http://www.flickr.com/services/oembed.xml'
  end
end

client = FlickrApi.new
client.fetch('http://www.flickr.com/photos/alex_soulim/3593916989')
```

It will return:

```ruby
{
  "type"=>"photo",
  "title"=>"IMG_2072",
  "author_name"=>"Alex Soulim", "author_url"=>"http://www.flickr.com/photos/alex_soulim/",
  "width"=>"683",
  "height"=>"1024",
  "url"=>"http://farm4.staticflickr.com/3618/3593916989_3d8aa991ea_b.jpg",
  "web_page"=>"http://www.flickr.com/photos/alex_soulim/3593916989/",
  "thumbnail_url"=>"http://farm4.staticflickr.com/3618/3593916989_3d8aa991ea_s.jpg",
  "thumbnail_width"=>"75",
  "thumbnail_height"=>"75",
  "web_page_short_url"=>"http://flic.kr/p/6tzLj2",
  "license"=>"All Rights Reserved",
  "license_id"=>"0",
  "version"=>"1.0",
  "cache_age"=>"3600",
  "provider_name"=>"Flickr",
  "provider_url"=>"http://www.flickr.com/"
}
```

You can make requests with additional parameters. Let's build a client for
Instagram and use `:maxwidth` parameter.

```ruby
require 'oembed'

class InstagramApi
  include Oembed::Client

  def endpoint_uri
    'http://api.instagram.com/oembed'
  end
end

client = InstagramApi.new
client.fetch('http://instagr.am/p/BUG/', maxwidth: 300)
```

If you need to always customise the fetch with additional parameters this can be done by providing a fetch method in the service class. In this example we are adding a maxwidth parameter to the request.

```ruby
require 'oembed'

class YoutubeApi
  include Oembed::Client

  def endpoint_uri
    'https://www.youtube.com/oembed'
  end

  def fetch(url, options={})
    super url, options.merge(maxwidth: 620)
  end
end

client = YoutubeApi.new
client.fetch('https://www.youtube.com/watch?v=_DRNgL76OLc')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Supported Ruby versions

This library is tested against the following Ruby implementations:

- MRI Ruby 2.1
- MRI Ruby 2.0
- MRI Ruby 1.9.3
- JRuby
