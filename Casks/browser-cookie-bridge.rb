cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.4.2"
  sha256 arm:   "e98af86845f4ee9dc1819a89739fcb0a331fa0b09319874966cf5a7586d66b89",
         intel: "fdd579cf0cb9f2769f5817c1e83ac284017cd9695cd7a381ca540df339637b46"

  url "https://github.com/apoorvdarshan/browser-cookie-bridge/releases/download/v#{version}/Browser-Cookie-Bridge-#{arch}.dmg",
      verified: "github.com/apoorvdarshan/browser-cookie-bridge/"
  name "Browser Cookie Bridge"
  desc "Transfer browser cookies and sessions locally on macOS"
  homepage "https://cookiebridge.apoorvdarshan.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :ventura"

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
