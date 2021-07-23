class Helmsman < Formula
  desc "Helm Charts as Code tool"
  homepage "https://github.com/Praqma/helmsman"
  url "https://github.com/Praqma/helmsman.git",
      tag:      "v3.7.2",
      revision: "6d7e6ddb2c7747b8789dd72db7714431fe17e779"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a307ed84ab8c572b9256fb54aaad6a7300f9384c94163dfeafc7419188aed4d0"
    sha256 cellar: :any_skip_relocation, big_sur:       "2f8fa84afd13560540da1be94ba442d8d140821436e14b038b8f034e561d7ca7"
    sha256 cellar: :any_skip_relocation, catalina:      "c0604c09ea08fd0aefb7ad9f24ec6df256156670fa8d30c180365c9b479cf99f"
    sha256 cellar: :any_skip_relocation, mojave:        "4841f957b4825a3501faa2ccf437d79042ea9019389ad344d4f20f9cecfe3830"
  end

  depends_on "go" => :build
  depends_on "helm"
  depends_on "kubernetes-cli"

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X main.version=#{version}", "./cmd/helmsman"
    pkgshare.install "examples/example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/helmsman version")

    output = shell_output("#{bin}/helmsman --apply -f #{pkgshare}/example.yaml 2>&1", 1)
    assert_match "helm diff not found", output
  end
end
