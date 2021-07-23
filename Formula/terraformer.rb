class Terraformer < Formula
  desc "CLI tool to generate terraform files from existing infrastructure"
  homepage "https://github.com/GoogleCloudPlatform/terraformer"
  url "https://github.com/GoogleCloudPlatform/terraformer/archive/0.8.15.tar.gz"
  sha256 "46b9c3c0e83c1775d2ce2cf89fbbd4dda82533cdc522a8d33e57f166c4c75808"
  license "Apache-2.0"
  head "https://github.com/GoogleCloudPlatform/terraformer.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e0d93f65a41ae9128de2d5be7d2bb4d367e49282d325e611f734a4f16d739d97"
    sha256 cellar: :any_skip_relocation, big_sur:       "3e9a452e670385b8b3d07dd414f3a5acc0b1d9bc99d8a76cf514d753ee1796cb"
    sha256 cellar: :any_skip_relocation, catalina:      "da2773b2e6412c1fe48b1e7f419a2b910a6ff52f9e9ad66f36c2442ed9d101b7"
    sha256 cellar: :any_skip_relocation, mojave:        "c5bf85906557b0219abd16ea81afad78efe8ac842586d47aa83855e503d2faff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7a899e24305ee716af7da8eeeebd2fb38910aedc668062a4028a39633ab13f2"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match version.to_s,
      shell_output("#{bin}/terraformer version")

    assert_match "Available Commands",
      shell_output("#{bin}/terraformer -h")

    assert_match "aaa",
      shell_output("#{bin}/terraformer import google --resources=gcs --projects=aaa 2>&1", 1)
  end
end
