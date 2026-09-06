cask "tethershot" do
  version "1.0.17"
  sha256 "843334be957b1e7aeaaba64ce6c87ef5d9bdff806f8cb665b5a5de105832994d"

  url "https://github.com/apoorvdarshan/TetherShot/releases/download/v#{version}/TetherShot-#{version}-universal.dmg",
      verified: "github.com/apoorvdarshan/TetherShot/"
  name "TetherShot"
  desc "Capture pixel-perfect iPhone screenshots"
  homepage "https://tethershot.apoorvdarshan.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "TetherShot.app"

  uninstall quit: "com.apoorvdarshan.tethershot"

  zap trash: [
    "~/Library/Logs/TetherShot.log",
    "~/Library/Preferences/com.apoorvdarshan.tethershot.plist",
  ]
end
