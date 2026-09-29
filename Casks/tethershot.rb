cask "tethershot" do
  version "1.0.19"
  sha256 "0a4a69f5908493b19a233f155ab24734ebb2399a6b16b20a825a3e7de32b4b3b"

  url "https://github.com/apoorvdarshan/TetherShot/releases/download/v#{version}/TetherShot-#{version}-universal.dmg"
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
