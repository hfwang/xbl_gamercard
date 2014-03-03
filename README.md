# XblGamercard

XBox Live gamercard and Live profile scraper. Scrapes Microsoft's sites, trading one kind of reliability (not relying on xboxleaders API) for another (having to scrape potentially changing output).

## Installation

Add this line to your application's Gemfile:

    gem 'xbl_gamercard'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xbl_gamercard

## Usage

There are two main classes, `XblGamercard::Gamercard` and `XblGamercard::LiveProfile`, representing two different views with slightly different data.

* Gamercard (Example: http://gamercard.xbox.com/en-US/Major%20Nelson.card)
* Live profile (Example: https://live.xbox.com/en-US/Profile?Gamertag=Major+Nelson)

Gamercard is the only one that reliably returns recent games, while Live profile is the only one that returns "presence". Both otherwise return largely the same set of data, name, bio, gamerscore, so forth. You can either call `.fetch(gamertag)` to use `Net::HTTP` to load the page and then parse it, or simply call `new` with the response body (if you have specific HTTP request-ing needs).

## Examples

```ruby
gamercard = XblGamercard::Gamercard.fetch("major nelson")
# You can also have used:
# response = Net::HTTP.get_response(URI(XblGamercard::Gamercard.url_for(gamertag)))
# gamercard = XblGamerCard::Gamercard.new(response.body)
gamercard.gamertag # Returns "Major Nelson"
gamercard.icon_url # Returns "http://avatar.xboxlive.com/avatar/Major%20Nelson/avatarpic-l.png"
gamercard.gamerscore # Returns 66947
gamercard.motto
gamercard.name
gamercard.bio
# Gamercard specific! You can get a list of recently played games:
game = gamercard.played_games[0]
game.title
game.icon_url
game.earned_gamerscore
game.available_gamerscore
game.earned_archievements
game.available_achievements
game.percentage_complete
```

The Live profile page is pretty similar, except for the addition of a `presence` and `avatar_image_url` method.

```ruby
profile = XblGamercard::LiveProfile.fetch("major nelson")
# You can also have used:
# response = Net::HTTP.get_response(URI(XblGamercard::LiveProfile.url_for(gamertag)))
# profile = XblGamerCard::LiveProfile.new(response.body)
profile.gamertag # Returns "Major Nelson"
profile.icon_url # Returns "http://avatar.xboxlive.com/avatar/Major%20Nelson/avatarpic-l.png"
profile.avatar_image_url # Returns "https://avatar-ssl.xboxlive.com/avatar/Major%20Nelson/avatar-body.png"
profile.gamerscore # Returns 66947
profile.presence # Returns something like "Last seen 2/28/2014 playing Xbox.com"
```

## Contributing

1. Fork it (http://github.com/hfwang/xbl_gamercard/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See Also

There is a ton of prior art out there. This gem scrapes the public profile pages, while I found the others deficient in a variety of ways.

* https://github.com/hypomodern/gamercard - Only scrapes the Live profile page (which no longer shows played games)
* https://github.com/greendog99/xbox_live - Actually uses mechanize to login, potentially flakey.

Xboxleaders (http://xboxleaders.github.io/) based gems, which is pretty slow/unreliable. :cry:
* https://github.com/barisbalic/gamertag
* https://github.com/Keithbsmiley/xboxleaders-gem
* https://github.com/nevern02/xbox_leaders
* https://github.com/nicolasiensen/xbox-live
