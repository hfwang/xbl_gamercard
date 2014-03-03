require "net/http"
require "nokogiri"
require "uri"

module XblGamercard
  class Gamercard
    attr_accessor :document

    def initialize(html)
      @document = Nokogiri::HTML(html)
    end

    def gamertag
      document.css("#Gamertag").text()
    end

    def gamerscore
      document.css("#Gamerscore").text().to_i
    end

    def name
      document.css("#Name").text()
    end

    def icon_url
      document.css("#Gamerpic")[0]["src"]
    end

    def played_games
      return document.css("ol#PlayedGames>li").select { |e|
        e["class"] != "Unplayed"
      }.map { |e|
        XblGamercard::GamercardGame.new(e)
      }
    end

    def self.fetch(gamertag)
      uri = URI(self.url_for(gamertag))
      contents = Net::HTTP.get_response(uri)
      return self.new(contents.body)
    end

    def self.url_for(gamertag)
      # Use URI.escape because we actually want percent encoding (%20 for space instead of +)
      return "http://gamercard.xbox.com/en-US/#{URI.escape(gamertag)}.card"
    end
  end
end
