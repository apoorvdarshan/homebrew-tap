cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.4.6"
  sha256 arm:   "ab8a15837206effc452007c9e479d8ed3fd3b13d78892ff925c4e1d487bb1690",
         intel: "f143b9f5a11ecabf94d2ee4be9c694304ae6c9626e9c6a2f24fedc5feb16dbc1"

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
