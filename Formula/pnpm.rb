class Pnpm < Formula
  require "language/node"

  desc "📦🚀 Fast, disk space efficient package manager"
  homepage "https://pnpm.io/"
  url "https://registry.npmjs.org/pnpm/-/pnpm-6.10.3.tgz"
  sha256 "11311440f52a8770fa18fdc0e95d8627b06c1a0ef89f9a7f8f7a24a5a6d217d5"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5e39cef7fd1b8e8715d678470b119052843d59fd7421c407fcdff24af3011044"
    sha256 cellar: :any_skip_relocation, big_sur:       "cbb69e29ac9cd2b924e9e1e8768a22798465e35ec48e0da244df1c8d57d4ddf6"
    sha256 cellar: :any_skip_relocation, catalina:      "cbb69e29ac9cd2b924e9e1e8768a22798465e35ec48e0da244df1c8d57d4ddf6"
    sha256 cellar: :any_skip_relocation, mojave:        "cbb69e29ac9cd2b924e9e1e8768a22798465e35ec48e0da244df1c8d57d4ddf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e39cef7fd1b8e8715d678470b119052843d59fd7421c407fcdff24af3011044"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/pnpm", "init", "-y"
    assert_predicate testpath/"package.json", :exist?, "package.json must exist"
  end
end
