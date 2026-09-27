cask "tethershot" do
  version "1.0.18"
  sha256 "266a7d48735d675e88f010956fe95864c3be40d91099dcab9129c42849bfeb28"

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
