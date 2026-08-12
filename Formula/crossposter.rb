class Crossposter < Formula
  desc "Local-first social publishing dashboard for accounts you control"
  homepage "https://crossposter.apoorvdarshan.com/"
  url "https://registry.npmjs.org/@apoorvdarshan/crossposter/-/crossposter-1.1.13.tgz"
  sha256 "4f90056d0908e5659822e2efa5dc5c643dd86f592693778af76c4c42985a2af1"
  license "MIT"

  livecheck do
    url "https://registry.npmjs.org/@apoorvdarshan%2fcrossposter/latest"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on "ffmpeg"
  depends_on "node"
  depends_on "python@3.14"

  def install
    system "npm", "install", *std_npm_args

    package_root = libexec/"lib/node_modules/@apoorvdarshan/crossposter"
    cd package_root do
      system formula_opt_bin("node")/"npm", "run", "build"
    end

    (bin/"crossposter").write <<~SH
      #!/bin/bash
      set -e

      if [[ -z "${CROSSPOSTER_DATA_DIR:-}" ]]; then
        if [[ "$(uname -s)" == "Darwin" ]]; then
          CROSSPOSTER_DATA_DIR="$HOME/Library/Application Support/Crossposter"
        else
          CROSSPOSTER_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/crossposter"
        fi
      fi

      mkdir -p "$CROSSPOSTER_DATA_DIR"
      export CROSSPOSTER_APP_ROOT="#{opt_libexec}/lib/node_modules/@apoorvdarshan/crossposter"
      export CROSSPOSTER_BREW_EXECUTABLE="#{HOMEBREW_PREFIX}/bin/brew"
      export CROSSPOSTER_DATA_DIR
      export CROSSPOSTER_INSTALL_SOURCE="homebrew"
      export CROSSPOSTER_NO_UPDATE="true"
      export CROSSPOSTER_RUN_MODE="production"
      export POSTER_ENABLE_CONFIG_UI="true"

      exec "#{formula_opt_bin("node")}/node" \
        "#{opt_libexec}/lib/node_modules/@apoorvdarshan/crossposter/bin/crossposter.mjs" "$@"
    SH
  end

  service do
    run [opt_bin/"crossposter", "--no-open", "--no-update"]
    keep_alive true
    log_path var/"log/crossposter.log"
    error_log_path var/"log/crossposter-error.log"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/crossposter --version").strip

    port = free_port
    data_dir = testpath/"data"
    log = testpath/"crossposter.log"
    pid = spawn bin/"crossposter", "--port", port.to_s, "--data-dir", data_dir.to_s,
                "--no-open", "--no-update", [:out, :err] => log.to_s

    begin
      sleep 3
      assert_match '"ok":true', shell_output("curl --silent http://127.0.0.1:#{port}/api/health")
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
