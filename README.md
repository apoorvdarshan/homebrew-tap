# Apoorv Darshan's Homebrew Tap

Signed and notarized macOS releases for open-source apps by
[Apoorv Darshan](https://github.com/apoorvdarshan).

## Install

Install a single Cask directly; Homebrew adds the tap automatically:

```bash
brew install --cask apoorvdarshan/tap/tethershot
brew install --cask apoorvdarshan/tap/browser-cookie-bridge
```

Both Casks install their application into `/Applications`. They use immutable
GitHub Release assets with SHA-256 verification.

## Upgrade

```bash
brew update
brew upgrade --cask --greedy tethershot browser-cookie-bridge
```

The apps also include their own signed update checkers. Homebrew marks them as
self-updating Casks, so `--greedy` includes them in an explicit Homebrew
upgrade.

## Uninstall

```bash
brew uninstall --cask tethershot
```

Use `--zap` only when you also want to remove local preferences and support
files:

```bash
brew uninstall --zap --cask browser-cookie-bridge
```

## Maintenance

The tap checks upstream GitHub Releases every six hours and updates Cask
versions and SHA-256 digests when a stable release changes. Every push is
audited with Homebrew's style, audit, and livecheck commands.

- [TetherShot](https://github.com/apoorvdarshan/TetherShot)
- [Browser Cookie Bridge](https://github.com/apoorvdarshan/browser-cookie-bridge)
