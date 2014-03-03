# -*- coding: utf-8 -*-
require "spec_helper"

describe "Gamercard" do
  it "escapes gamertag with right escape style" do
    url = XblGamercard::Gamercard.url_for("Major Nelson")
    expect(url).to eq("http://gamercard.xbox.com/en-US/Major%20Nelson.card")
  end

  context "with thegoldenrecord's data", :vcr => true do
    it "passes sanity checks" do
      gamercard = XblGamercard::Gamercard.fetch("thegoldenrecord")
      expect(gamercard.gamertag).to eq("thegoldenrecord")
      expect(gamercard.gamerscore).to eq(3845)
      expect(gamercard.location).to eq("")
      expect(gamercard.motto).to eq("")
      expect(gamercard.name).to eq("Chris")
      expect(gamercard.bio).to eq("")
      expect(gamercard.icon_url).to eq("http://image.xboxlive.com/global/t.584109c0/tile/0/2000e")
      expect(gamercard.played_games).to have(5).items

      first_game = gamercard.played_games[0]

      # This silliness brought to you by... unicode!
      if RUBY_VERSION < "1.9"
        expect(first_game.title).to eq("F1 2011\342\204\242")
      else
        expect(first_game.title).to eq("F1 2011™")
      end
      expect(first_game.icon_url).to eq("http://tiles.xbox.com/tiles/+N/OB/1Wdsb2JhbA9ECgQLG1QfVltRL2ljb24vMC84MDAwIAAAAAAAAPqu0+c=.jpg")
      expect(first_game.last_played).to eq("2/27/2014")
      expect(first_game.earned_gamerscore).to eq(195)
      expect(first_game.available_gamerscore).to eq(1000)
      expect(first_game.earned_achievements).to eq(9)
      expect(first_game.available_achievements).to eq(38)
      expect(first_game.percentage_complete).to eq(23)
    end
  end

  context "with rider2710's data", :vcr => true do
    it "passes (minimal) sanity checks" do
      gamercard = XblGamercard::Gamercard.fetch("rider2710")
      expect(gamercard.gamertag).to eq("rider2710")
    end
  end
end
