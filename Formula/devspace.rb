class Devspace < Formula
  desc "CLI helps develop/deploy/debug apps with Docker and k8s"
  homepage "https://devspace.sh/"
  url "https://github.com/loft-sh/devspace.git",
      tag:      "v5.14.4",
      revision: "91f7c4668b383bb579892b7f2401e61c3b4d06da"
  license "Apache-2.0"
  head "https://github.com/loft-sh/devspace.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "07ec01624109b2d8aaaca202319d088689e0e22dbfac72974581a04f24a558b7"
    sha256 cellar: :any_skip_relocation, big_sur:       "86e068503bf9244e5231a02488688fd0feb1d8d02b7cf1829a640c6fade9f50e"
    sha256 cellar: :any_skip_relocation, catalina:      "b0a18eb68488bd199ee6d15a3456d2745f599d9e6ff7c28b8c5cb1c801d5a291"
    sha256 cellar: :any_skip_relocation, mojave:        "e983105d9568bc128938fb5734e0ed821cb1a9c05003b3a74e183c012797e94c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d2bce25551844cbf8b9a847a22a2c83828bea9982442d4465be0799a8240655b"
  end

  depends_on "go" => :build
  depends_on "kubernetes-cli"

  def install
    ldflags = %W[
      -s -w
      -X main.commitHash=#{Utils.git_head}
      -X main.version=#{version}
    ]
    system "go", "build", "-ldflags", ldflags.join(" "), *std_go_args
  end

  test do
    help_output = "DevSpace accelerates developing, deploying and debugging applications with Docker and Kubernetes."
    assert_match help_output, shell_output("#{bin}/devspace help")

    init_help_output = "Initializes a new devspace project"
    assert_match init_help_output, shell_output("#{bin}/devspace init --help")
  end
end
