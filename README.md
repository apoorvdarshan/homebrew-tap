# Apoorv Darshan's Homebrew Tap

Homebrew packages for open-source apps and tools by
[Apoorv Darshan](https://github.com/aopv).

## Install

Install a package directly; Homebrew adds the tap automatically:

```bash
brew install --cask aopv/tap/tethershot
brew install --cask aopv/tap/browser-cookie-bridge
```

Both Casks install their application into `/Applications` and use immutable
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

The tap checks upstream GitHub releases every six hours and updates Cask
versions and SHA-256 digests when a stable release changes. Every push is
audited with Homebrew's style, audit, and livecheck checks.

- [TetherShot](https://github.com/aopv/TetherShot)
- [Browser Cookie Bridge](https://github.com/aopv/browser-cookie-bridge)
