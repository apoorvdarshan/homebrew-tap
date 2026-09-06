cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.5.1"
  sha256 arm:   "756dbf6909d42472452e8c497e17dae35dc84e438b9b611ca487b3e8d15dea94",
         intel: "9cdd896b2c0d3ab94dba4ec7ac14dc52a2ae5c3cfe87707431f7e533a88bbd06"

  url "https://github.com/apoorvdarshan/browser-cookie-bridge/releases/download/v#{version}/Browser-Cookie-Bridge-#{arch}.dmg",
      verified: "github.com/apoorvdarshan/browser-cookie-bridge/"
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
