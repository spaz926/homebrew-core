class Kakoune < Formula
  desc "Selection-based modal text editor"
  homepage "https://github.com/mawww/kakoune"
  license "Unlicense"
  head "https://github.com/mawww/kakoune.git"

  # Remove stable block in next release with merged patch
  stable do
    url "https://github.com/mawww/kakoune/releases/download/v2020.09.01/kakoune-2020.09.01.tar.bz2"
    sha256 "861a89c56b5d0ae39628cb706c37a8b55bc289bfbe3c72466ad0e2757ccf0175"

    # Fix build for GCC: error: 'numeric_limits' is not a member of 'std'
    # Remove in the next release
    patch do
      url "https://github.com/mawww/kakoune/commit/a0c23ccb720cb10469c4dfd77342524d6f607a9c.patch?full_index=1"
      sha256 "01608c5bee3afb00593bddb1289fdec25d4e236aa00c0997a99c3c66ff7bb04d"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "6a6af6d41f893e851691984867efeee176098f47c881d5fe77d8534bc4086375"
    sha256 cellar: :any,                 big_sur:       "61064437727a2eb062b89941b25fb46c017d350e8947e867e72f51f591d030ad"
    sha256 cellar: :any,                 catalina:      "9cb8ffd67651eab6f269daab2bbf4e66adf4f7dad4029a3285631a3615cf1514"
    sha256 cellar: :any,                 mojave:        "00c9127f14d643eee79fc64d02874bc131dad426fb11580b5d4fa43a3a51007c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d1f01dd8fea918ffb45c5fa7e2f3d233637768eaa9d2b7a65d1df136f9a03364"
  end

  depends_on macos: :high_sierra # needs C++17
  depends_on "ncurses"

  uses_from_macos "libxslt" => :build

  on_linux do
    depends_on "binutils" => :build
    depends_on "linux-headers" => :build
    depends_on "pkg-config" => :build
    depends_on "gcc"
  end

  fails_with gcc: "5"
  fails_with gcc: "6"

  def install
    cd "src" do
      system "make", "install", "debug=no", "PREFIX=#{prefix}"
    end
  end

  test do
    system bin/"kak", "-ui", "dummy", "-e", "q"
  end
end
