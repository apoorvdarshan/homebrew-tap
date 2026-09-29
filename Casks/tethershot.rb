cask "tethershot" do
  version "1.0.20"
  sha256 "092d524559f47fe0451f9749e55b9de27eca0ad28b4b776db8e24e7bdc9598f1"

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
