module XblGamercard
  class GamercardGame
    include XblGamercard::MicroScraper
    attr_accessor :element

    def initialize(element)
      @element = element
    end

    extract_text ".Title"
    extract_text ".LastPlayed"
    extract_int ".EarnedGamerscore"
    extract_int ".AvailableGamerscore"
    extract_int ".EarnedAchievements"
    extract_int ".AvailableAchievements"
    # Text is actually something like "99%", but to_i results in 99
    extract_int ".PercentageComplete"
    extract("img", :as => :icon_url) { |e| e["src"] }
  end
end
