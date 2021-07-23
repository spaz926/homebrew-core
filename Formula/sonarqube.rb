class Sonarqube < Formula
  desc "Manage code quality"
  homepage "https://www.sonarqube.org/"
  url "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.0.0.45539.zip"
  sha256 "b5a8a5330527515ddf34cbd4f6284b5ccec1d9c4384c46eb1786101ee7e2c065"
  license "LGPL-3.0-or-later"

  livecheck do
    url "https://binaries.sonarsource.com/Distribution/sonarqube/"
    regex(/href=.*?sonarqube[._-]v?(\d+(?:\.\d+)+)\.zip/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9e70fe81f87e9b1b9d3ba69f02e987d47505c1c49e0163f1a1f91aee1d35655c"
    sha256 cellar: :any_skip_relocation, big_sur:       "b26f126b981440dbfd0bcecf145fbb48b548f46c93d0c26e8d02b63bd8347103"
    sha256 cellar: :any_skip_relocation, catalina:      "b26f126b981440dbfd0bcecf145fbb48b548f46c93d0c26e8d02b63bd8347103"
    sha256 cellar: :any_skip_relocation, mojave:        "476709c0932f4bb2fb01df928b4ee49534833347c2709339bb0ad32ffad943d0"
  end

  depends_on "openjdk@11"

  conflicts_with "sonarqube-lts", because: "both install the same binaries"

  def install
    # Delete native bin directories for other systems
    rm_rf Dir["bin/{linux,windows}-*"]

    libexec.install Dir["*"]

    (bin/"sonar").write_env_script libexec/"bin/macosx-universal-64/sonar.sh",
      Language::Java.overridable_java_home_env("11")
  end

  plist_options manual: "sonar console"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
          <string>#{opt_bin}/sonar</string>
          <string>start</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
      </dict>
      </plist>
    EOS
  end

  test do
    assert_match "SonarQube", shell_output("#{bin}/sonar status", 1)
  end
end
