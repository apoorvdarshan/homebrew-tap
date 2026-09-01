cask "browser-cookie-bridge" do
  arch arm: "arm64", intel: "x64"

  version "1.4.7"
  sha256 arm:   "475f6ccbcfc299855e47c9db002e8f2dfb0d7384606921040921f47c8643e429",
         intel: "023067813189b5408e218105ceddced3cc45b0af5a64ad8d5846d2399099954e"

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
