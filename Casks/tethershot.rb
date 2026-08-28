cask "tethershot" do
  version "1.0.10"
  sha256 "c27c6376be54af8306b3d318c4a1d4ad221ac18ec80b5d479560a0b236dae520"

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
