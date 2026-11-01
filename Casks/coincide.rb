cask "coincide" do
  version "0.1.0"
  sha256 "b4bb4fe1c2e6c8d504d09c4bfd5aadf8309df1b4eab69e66155b213bf7e65ce5"

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

  # When it starts, Coincide links its `coincide` command into one of these folders
  # (TerminalToolInstallation.swift). Only a link into Coincide.app is removed, never another tool's
  # `coincide`. An upgrade removes it too, and the new app puts it back when it starts.
  uninstall_postflight_steps do
    remove ["/opt/homebrew/bin/coincide", "/usr/local/bin/coincide"],
           symlink_target_contains: "Coincide.app/Contents/Helpers/coincide"
    remove ".local/bin/coincide",
           base:                    :home,
           symlink_target_contains: "Coincide.app/Contents/Helpers/coincide"
  end

  # The in-app updater keeps the version it replaced beside the app as a hidden backup
  # (UpdateInstallation.swift), which would otherwise outlive the app.
  uninstall launchctl: [
              "com.apoorvdarshan.coincide.agent-host",
              "com.apoorvdarshan.coincide.always-on",
              "com.apoorvdarshan.coincide.power-helper",
            ],
            quit:      "com.apoorvdarshan.coincide",
            trash:     "#{appdir}/.Coincide-backup-*.app"

  # `trash:` can't reach the Keychain, so the script deletes Coincide's own items from the login
  # Keychain: the generic passwords of its five services (agent account and dictation API keys,
  # saved logins, the Bitwarden session, paired Remote devices) and Coincide Remote's certificate
  # and private key. Coincide Debug's items are named differently and stay.
  #
  # ~/.coincide/worktrees is left alone: it holds git worktrees of the user's own repositories,
  # which can have uncommitted or unpushed work, and deleting them by hand leaves the repositories
  # pointing at missing worktrees. `rmdir:` removes ~/.coincide only once it holds no files.
  # Also kept: ~/Downloads/Coincide (the browser's downloads) and any instruction file synced to
  # iCloud Drive › Coincide.
  zap script: {
        executable:   "/bin/sh",
        args:         [
          "-c",
          <<~SH,
            for service in provider-account voice browser browser-logins remote; do
              while /usr/bin/security delete-generic-password -s "com.apoorvdarshan.coincide.$service" >/dev/null 2>&1; do :; done
            done
            while /usr/bin/security delete-identity -c "Coincide Remote" >/dev/null 2>&1; do :; done
            while /usr/bin/security delete-certificate -c "Coincide Remote" >/dev/null 2>&1; do :; done
          SH
        ],
        must_succeed: false,
      },
      trash:  [
        "~/Library/Application Support/Coincide",
        "~/Library/Caches/com.apoorvdarshan.coincide",
        "~/Library/HTTPStorages/com.apoorvdarshan.coincide",
        "~/Library/Preferences/com.apoorvdarshan.coincide.agent-host.plist",
        "~/Library/Preferences/com.apoorvdarshan.coincide.plist",
        "~/Library/Saved Application State/com.apoorvdarshan.coincide.savedState",
        "~/Library/WebKit/com.apoorvdarshan.coincide",
      ],
      rmdir:  "~/.coincide"
end
