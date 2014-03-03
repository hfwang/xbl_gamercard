 "spec_helper"

describe "LiveProfile" do
  it "escapes gamertag with right escape style" do
    url = XblGamercard::LiveProfile.url_for("Major Nelson")
    expect(url).to eq("https://live.xbox.com/en-US/Profile?Gamertag=Major+Nelson")
  end

  context "with thegoldenrecord's data", :vcr => true do
    it "passes sanity checks" do
      gamercard = XblGamercard::LiveProfile.fetch("thegoldenrecord")
      expect(gamercard.presence).to eq("Last seen 2/27/2014 playing Xbox Dashboard")
    end
  end

  context "with rider2710's data", :vcr => true do
    it "passes (minimal) sanity checks" do
      gamercard = XblGamercard::LiveProfile.fetch("rider2710")
      expect(gamercard.presence).to eq("Last seen 3/1/2014 playing Xbox One")
    end
  end
end
