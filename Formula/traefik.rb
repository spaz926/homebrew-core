class Traefik < Formula
  desc "Modern reverse proxy"
  homepage "https://traefik.io/"
  url "https://github.com/traefik/traefik/releases/download/v2.4.11/traefik-v2.4.11.src.tar.gz"
  sha256 "76a35f5028ca355bfec42ceb50bd546ac1566d1060b1754cfa6881b8f69fc26c"
  license "MIT"
  head "https://github.com/traefik/traefik.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7674d9baadeae9d98c457688f81c9f733825c15f11953b31674278f6099e5b67"
    sha256 cellar: :any_skip_relocation, big_sur:       "85c140f0271d40a673b5c716ec0ccccbf29bc457b454e06dda955a17a7def50b"
    sha256 cellar: :any_skip_relocation, catalina:      "37470bee7ddd929cf7e6381cc0af6005d2f2cbee306707917096d2ff9343b46d"
    sha256 cellar: :any_skip_relocation, mojave:        "1f961cd97f67d2231af311b4416683c25149f97ec5ca13c7b2e2d54b540a5440"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d7647c436187ebd0bf87e8418603f0e9fa459117edf2fe039c0b0d5ab74e0c9"
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  def install
    system "go", "generate"
    system "go", "build",
      "-ldflags", "-s -w -X github.com/traefik/traefik/v#{version.major}/pkg/version.Version=#{version}",
      "-trimpath", "-o", bin/"traefik", "./cmd/traefik"
  end

  plist_options manual: "traefik"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <false/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/traefik</string>
            <string>--configfile=#{etc/"traefik/traefik.toml"}</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/traefik.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/traefik.log</string>
        </dict>
      </plist>
    EOS
  end

  test do
    ui_port = free_port
    http_port = free_port

    (testpath/"traefik.toml").write <<~EOS
      [entryPoints]
        [entryPoints.http]
          address = ":#{http_port}"
        [entryPoints.traefik]
          address = ":#{ui_port}"
      [api]
        insecure = true
        dashboard = true
    EOS

    begin
      pid = fork do
        exec bin/"traefik", "--configfile=#{testpath}/traefik.toml"
      end
      sleep 5
      cmd_ui = "curl -sIm3 -XGET http://127.0.0.1:#{http_port}/"
      assert_match "404 Not Found", shell_output(cmd_ui)
      sleep 1
      cmd_ui = "curl -sIm3 -XGET http://127.0.0.1:#{ui_port}/dashboard/"
      assert_match "200 OK", shell_output(cmd_ui)
    ensure
      Process.kill(9, pid)
      Process.wait(pid)
    end

    assert_match version.to_s, shell_output("#{bin}/traefik version 2>&1")
  end
end
