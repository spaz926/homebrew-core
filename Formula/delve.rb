class Delve < Formula
  desc "Debugger for the Go programming language"
  homepage "https://github.com/go-delve/delve"
  url "https://github.com/go-delve/delve/archive/v1.7.0.tar.gz"
  sha256 "0504f7ea8d63a8f6eccac9f7071f9ac45f8123151ce53aedbf539f83808d122b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d01e0c34ed53bef69cbccac5e659b4b5691ee61b28461dd76dab1a3b6ec4a5d8"
    sha256 cellar: :any_skip_relocation, big_sur:       "962e2a4a3a1ec84c63c3ed15bfe65f983fbc281f6bf4cd61751d5fa51b23d984"
    sha256 cellar: :any_skip_relocation, catalina:      "88800908c79768be3ae31ef540f993344c75d635a9c028304859a3e3ec47b676"
    sha256 cellar: :any_skip_relocation, mojave:        "4ca03590255e921f4dc68037f6871d4e396deb1a76fe4e785209a107e958c573"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-o", bin/"dlv", "./cmd/dlv"
  end

  test do
    assert_match(/^Version: #{version}$/, shell_output("#{bin}/dlv version"))
  end
end
