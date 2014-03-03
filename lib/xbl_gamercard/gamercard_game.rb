module XblGamercard
  class GamercardGame
    def initialize(elem)
      @elem = elem
    end

    FIELD_TO_ELEMENT_MAP = {
      :title => ".Title",
      :last_played => ".LastPlayed",
      :earned_gamerscore_raw => ".EarnedGamerscore",
      :available_gamerscore_raw => ".AvailableGamerscore",
      :earned_achievements_raw => ".EarnedAchievements",
      :available_achievements_raw => ".AvailableAchievements",
      :percentage_complete_raw => ".PercentageComplete"
    }
    FIELD_TO_ELEMENT_MAP.each do |name, element_selector|
      define_method(name) do
        @elem.css(element_selector).text()
      end
    end
    INT_FIELDS = [ :earned_gamerscore, :available_gamerscore,
                   :earned_achievements, :available_achievements,
                   :percentage_complete ]
    INT_FIELDS.each do |name|
      define_method(name) do
        self.send("#{name}_raw").to_i
      end
    end

    def icon_url
      @elem.css("img")[0]["src"]
    end
  end
end
