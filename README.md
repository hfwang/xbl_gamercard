# XblGamercard

XBox Live gamercard and Live profile scraper. Scrapes Microsoft's sites, trading
one kind of reliability (not relying on xboxleaders API) for another ()

## Installation

Add this line to your application's Gemfile:

    gem 'xbl_gamercard'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xbl_gamercard

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it (http://github.com/hfwang/xbl_gamercard/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## See Also

There is a ton of prior art out there. This gem scrapes the public profile
pages, while I found the others deficient in a variety of ways.

* https://github.com/hypomodern/gamercard - Only scrapes the Live profile page
  (which no longer shows played games)
* https://github.com/greendog99/xbox_live - Actually uses mechanize to login,
  potentially flakey.

Xboxleaders (http://xboxleaders.github.io/) based gems, which is pretty
slow/unreliable. :cry:
* https://github.com/barisbalic/gamertag
* https://github.com/Keithbsmiley/xboxleaders-gem
* https://github.com/nevern02/xbox_leaders
* https://github.com/nicolasiensen/xbox-live
