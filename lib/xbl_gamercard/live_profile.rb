require "net/https"
require "nokogiri"
require "uri"

module XblGamercard
  class LiveProfile
    attr_accessor :document

    def initialize(html)
      @document = Nokogiri::HTML(html)
    end

    def presence
      document.css(".links .presence").text()
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
