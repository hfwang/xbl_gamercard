require "spec_helper"

describe "Gamercard" do
  context "with thegoldenrecord's data", :vcr => true do
    it "passes sanity checks" do
      gamercard = XblGamercard::Gamercard.fetch("thegoldenrecord")
      expect(gamercard.gamertag).to eq("thegoldenrecord")
      expect(gamercard.gamerscore).to eq(3845)
      expect(gamercard.name).to eq("Chris")
      expect(gamercard.icon_url).to eq("http://image.xboxlive.com/global/t.584109c0/tile/0/2000e")
      expect(gamercard.played_games).to have(5).items
    end
  end

  context "with rider2710's data", :vcr => true do
    it "passes (minimal) sanity checks" do
      gamercard = XblGamercard::Gamercard.fetch("rider2710")
      expect(gamercard.gamertag).to eq("rider2710")
    end
  end
end
