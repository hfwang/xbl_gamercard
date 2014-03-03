require "spec_helper"

describe "LiveProfile" do
  it "escapes gamertag with right escape style" do
    url = XblGamercard::LiveProfile.url_for("Major Nelson")
    expect(url).to eq("https://live.xbox.com/en-US/Profile?Gamertag=Major+Nelson")
  end

  context "with thegoldenrecord's data", :vcr => true do
     it "passes sanity checks" do
      gamercard = XblGamercard::LiveProfile.fetch("thegoldenrecord")
      expect(gamercard.gamertag).to eq("thegoldenrecord")
      expect(gamercard.gamerscore).to eq(3845)
      expect(gamercard.location).to eq("")
      expect(gamercard.motto).to eq("")
      expect(gamercard.name).to eq("Chris")
      expect(gamercard.bio).to eq("")
      expect(gamercard.icon_url).to eq("https://avatar-ssl.xboxlive.com/global/t.584109c0/tile/0/2000e")

      expect(gamercard.avatar_image_url).to eq("https://avatar-ssl.xboxlive.com/avatar/thegoldenrecord/avatar-body.png")
      expect(gamercard.presence).to eq("Last seen 2/27/2014 playing Xbox Dashboard")
    end
  end

  context "with rider2710's data", :vcr => true do
    it "passes (minimal) sanity checks" do
      gamercard = XblGamercard::LiveProfile.fetch("rider2710")
      expect(gamercard.motto).to eq("Fast & Bulbous")
      expect(gamercard.presence).to eq("Last seen 3/1/2014 playing Xbox One")
    end
  end
end
