require "net/http"
require "nokogiri"
require "uri"

module XblGamercard
  class Gamercard
    include XblGamercard::MicroScraper

    attr_accessor :element

    def initialize(html)
      @element = Nokogiri::HTML(html)
    end

    extract_text("#Gamertag")
    extract_int("#Gamerscore")
    extract_text("#Name")
    extract("#Gamerpic", :as => :icon_url) { |e| e["src"] }

    def played_games
      return element.css("ol#PlayedGames>li").select { |e|
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
