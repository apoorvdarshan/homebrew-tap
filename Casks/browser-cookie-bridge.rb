cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.5.3"
  sha256 arm:   "893ce4c9499ec12d2d17d1be57e745ff8515c02a8358326094958cfc6179ed95",
         intel: "1d11c3154aa933d7bc14bb975deae5984f047dac523c2d19f65adc684ec6aee7"

  url "https://github.com/apoorvdarshan/browser-cookie-bridge/releases/download/v#{version}/Browser-Cookie-Bridge-#{arch}.dmg"
  name "Browser Cookie Bridge"
  desc "Transfer browser cookies and signed-in sessions locally"
  homepage "https://cookiebridge.apoorvdarshan.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Browser Cookie Bridge.app"

  uninstall quit: "com.apoorvdarshan.browser-cookie-bridge"

  zap trash: [
    "~/Library/Application Support/BraveCodexCookieSync",
    "~/Library/LaunchAgents/com.apoorvdarshan.brave-codex-cookie-sync.app-login.plist",
    "~/Library/LaunchAgents/com.apoorvdarshan.brave-codex-cookie-sync.login-sync.plist",
    "~/Library/LaunchAgents/com.apoorvdarshan.brave-codex-cookie-sync.plist",
    "~/Library/Preferences/com.apoorvdarshan.browser-cookie-bridge.plist",
  ]
end
