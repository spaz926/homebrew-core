class Starship < Formula
  desc "Cross-shell prompt for astronauts"
  homepage "https://starship.rs"
  url "https://github.com/starship/starship/archive/v0.56.0.tar.gz"
  sha256 "ab038a2cc1ea0b6c6ebbf064f531f22448ee1ed8d04b5f25b327ead1ad22cca5"
  license "ISC"
  head "https://github.com/starship/starship.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ee220286072f0ad9b7b9c336c7cb5287f3000d1a5d32e468bb1622e2247813e7"
    sha256 cellar: :any_skip_relocation, big_sur:       "99d37a1d5a512c50de12c8cb8b4ea2d20c90c686f4b5dd11b16c3af01b65175a"
    sha256 cellar: :any_skip_relocation, catalina:      "b466d0da340b348c1b43cab52006bf6731d1bc7bf79e062e88135637804d6c55"
    sha256 cellar: :any_skip_relocation, mojave:        "bc1fac2b4e6ceeef39cde3863b8d267255432b3089eae2c352cefec2ee9bada4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "037b26bb05cd527e60b27671581656d195ab1ca9733f9ccf3d91a057b32ea39b"
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "dbus"
  end

  def install
    system "cargo", "install", "--features", "notify-rust", *std_cargo_args

    bash_output = Utils.safe_popen_read("#{bin}/starship", "completions", "bash")
    (bash_completion/"starship").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/starship", "completions", "zsh")
    (zsh_completion/"_starship").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/starship", "completions", "fish")
    (fish_completion/"starship.fish").write fish_output
  end

  test do
    ENV["STARSHIP_CONFIG"] = ""
    assert_equal "[1;32m❯[0m ", shell_output("#{bin}/starship module character")
  end
end
