cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.5.2"
  sha256 arm:   "e69d93b50fe3843283b56668f29a897929a4b2ff50ee612e77f49fd393721f08",
         intel: "2d31b25893c23fda2d114bbc805ca7d5fae30a14e4c31bf842594c8bb307e24e"

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
