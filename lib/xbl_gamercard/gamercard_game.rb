module XblGamercard
  class GamercardGame
    def initialize(elem)
      @elem = elem
    end

    FIELD_TO_ELEMENT_MAP = {
      :title => ".Title",
      :last_played => ".LastPlayed",
      :earned_gamerscore => ".EarnedGamerscore",
      :available_gamerscore => ".AvailableGamerscore",
      :earned_achievements => ".EarnedAchievements",
      :available_achievements => ".AvailableAchievements",
      :percentage_columete => ".PercentageComplete"
    }
    FIELD_TO_ELEMENT_MAP.each do |name, element_selector|
      define_method(name) do
        @elem.css(element_selector).text()
      end
    end

    def icon_url
      @elem.css("img")[0]["src"]
    end
  end
end
