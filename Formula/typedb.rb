class Typedb < Formula
  desc "Distributed hyper-relational database for knowledge engineering"
  homepage "https://vaticle.com/"
  url "https://github.com/vaticle/typedb/releases/download/2.2.0/typedb-all-mac-2.2.0.zip"
  sha256 "906f4e101c377826c61dc3d7a7958611cb0ee31d240989a58666499c6b8f08d5"
  license "AGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "0af942bfa93dc5df5279ea36ec33b42108baad4ae9ab9e65ac2b80b178765cf3"
  end

  depends_on "openjdk@11"

  def install
    libexec.install Dir["*"]
    bin.install libexec/"typedb"
    bin.env_script_all_files(libexec, Language::Java.java_home_env("11"))
  end

  test do
    assert_match "A STRONGLY-TYPED DATABASE", shell_output("#{bin}/typedb server status")
  end
end
