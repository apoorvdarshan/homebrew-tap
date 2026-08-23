cask "tethershot" do
  version "1.0.9"
  sha256 "2a964b4ee9065cae609bb7da870b9e8a059b0cc6f2249943a2f2c8125ce3f560"

  url "https://github.com/aopv/TetherShot/releases/download/v#{version}/TetherShot-#{version}-universal.dmg",
      verified: "github.com/aopv/TetherShot/"
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
