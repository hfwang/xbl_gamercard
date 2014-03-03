require "net/https"
require "nokogiri"
require "uri"
require "cgi"

module XblGamercard
  class LiveProfile
    include XblGamercard::MicroScraper

    attr_accessor :element

    def initialize(html)
      @element = Nokogiri::HTML(html)
    end

    extract("article.profile.you", :as => :gamertag) { |e| e["data-gamertag"] }
    extract("article.profile.you img.gamerpic", :as => "icon_url") { |e| e["src"] }
    extract_text "article.profile.you .basics .name .value", :as => :name
    extract_text "article.profile.you .location .value", :as => :location
    extract_text "article.profile.you .bio .value", :as => :bio
    extract(".motto") { |e| e.nil? ? "" : e.text.strip }
    extract_int "article.profile.you .basics .gamerscore"

    extract_text ".links .presence"

    def avatar_image_url
      "https://avatar-ssl.xboxlive.com/avatar/#{URI.escape(gamertag)}/avatar-body.png"
    end

    def self.fetch(gamertag)
      uri = URI(self.url_for(gamertag))
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      return self.new(response.body)
    end

    def self.url_for(gamertag)
      return "https://live.xbox.com/en-US/Profile?Gamertag=#{CGI.escape(gamertag)}"
    end
  end
end
