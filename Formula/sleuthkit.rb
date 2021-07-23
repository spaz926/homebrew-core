class Sleuthkit < Formula
  desc "Forensic toolkit"
  homepage "https://www.sleuthkit.org/"
  url "https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-4.10.2/sleuthkit-4.10.2.tar.gz"
  sha256 "c4836b7fd57b0a7a45432eeee18c41833027c8980fab3e4961c733b4e6867686"
  license "GPL-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/sleuthkit[._-]v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "2019d39f5f7125a51c9b355d1106fb87a7ff69dd8468e4a7ac862f5ef4c63199"
    sha256 cellar: :any,                 big_sur:       "c24c26b12e348409df732b847a5bf889dc9be429a0cb102595dc90576e0de320"
    sha256 cellar: :any,                 catalina:      "be14b5b898b736334e74427335411f5ccaf05c462e45c367a61a1399155293f0"
    sha256 cellar: :any,                 mojave:        "fa11e725245a2b893d8f781afc5b9e80e9e0c064a0030f87f45ac907fb2fb839"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "81704d55ba8566b62471c56ec6e2110a8ac0d1fc9f7de3d6e84967602a353e9d"
  end

  depends_on "ant" => :build
  depends_on "afflib"
  depends_on "libewf"
  depends_on "libpq"
  depends_on "openjdk"

  uses_from_macos "sqlite"

  conflicts_with "ffind", because: "both install a `ffind` executable"

  def install
    on_macos { ENV["SED"] = "/usr/bin/sed" }
    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix
    ENV["ANT_FOUND"] = Formula["ant"].opt_bin/"ant"
    ENV.append_to_cflags "-DNDEBUG"

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"

    cd "bindings/java" do
      system "ant"

      on_linux do
        inreplace "Makefile", HOMEBREW_LIBRARY/"Homebrew/shims/linux/super/ld", "ld"
        inreplace "jni/Makefile", HOMEBREW_LIBRARY/"Homebrew/shims/linux/super/ld", "ld"
      end
    end
    prefix.install "bindings"
  end

  test do
    system "#{bin}/tsk_loaddb", "-V"
  end
end
