cask "coincide" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/apoorvdarshan/coincide/releases/download/v#{version}/Coincide-#{version}.dmg"
  name "Coincide"
  desc "Native workspace for Claude Code, Codex, Cursor and other coding agents"
  homepage "https://coincide.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :tahoe

  app "Coincide.app"

  uninstall launchctl: [
              "com.apoorvdarshan.coincide.agent-host",
              "com.apoorvdarshan.coincide.always-on",
              "com.apoorvdarshan.coincide.power-helper",
            ],
            quit:      "com.apoorvdarshan.coincide"

  zap trash: [
    "~/Library/Application Support/Coincide",
    "~/Library/Caches/com.apoorvdarshan.coincide",
    "~/Library/HTTPStorages/com.apoorvdarshan.coincide",
    "~/Library/Preferences/com.apoorvdarshan.coincide.agent-host.plist",
    "~/Library/Preferences/com.apoorvdarshan.coincide.plist",
    "~/Library/Saved Application State/com.apoorvdarshan.coincide.savedState",
    "~/Library/WebKit/com.apoorvdarshan.coincide",
  ]
end
