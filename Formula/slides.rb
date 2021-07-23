class Slides < Formula
  desc "Terminal based presentation tool"
  homepage "https://github.com/maaslalani/slides"
  url "https://github.com/maaslalani/slides/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "f1c3494ec8d52ebb0351f1722d60ad4f4dd56b1f649130adfe59db8c9ffaeae2"
  license "MIT"
  head "https://github.com/maaslalani/slides.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2ad9d282dd70dff8686a1804c6fac087521eaf465b2edd3f745f0dffa78f6174"
    sha256 cellar: :any_skip_relocation, big_sur:       "420a4a7eb301fe4888d5eba71629e693ef0227017c0d6c548b6200323d3886b2"
    sha256 cellar: :any_skip_relocation, catalina:      "14d458824951b4254324782a0a4c74c872db3a46604e22405d35d0a9c32147d0"
    sha256 cellar: :any_skip_relocation, mojave:        "32b13c126a51256d58eaec1fe02d748ed7a6f6a825c7b83ccf31677bab9dd90f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"test.md").write <<-MARKDOWN
    # Slide 1
    Content

    ---

    # Slide 2
    More Content
    MARKDOWN

    # Bubbletea-based apps are hard to test even under PTY.spawn (or via
    # expect) because they rely on vt100-like answerback support, such as
    # "<ESC>[6n" to report the cursor position. For now we just run the command
    # for a second and see that it tried to send some ANSI out of it.
    require "pty"
    r, _, pid = PTY.spawn "#{bin}/slides test.md"
    sleep 1
    Process.kill("TERM", pid)
    assert_match(/\e\[/, r.read)
  end
end
