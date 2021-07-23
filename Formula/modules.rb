class Modules < Formula
  desc "Dynamic modification of a user's environment via modulefiles"
  homepage "https://modules.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/modules/Modules/modules-4.8.0/modules-4.8.0.tar.bz2"
  sha256 "e9254c93efcbd17806a421eb414f7ce22fee37108748b02562cded851b46bfaa"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/modules[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256               arm64_big_sur: "1e68e132bea8d5133661124ada2eb86e28b2df6f02add99a8db81f0372f7ebf6"
    sha256               big_sur:       "f7db523c25f10422709babd29da071fb844fb8207ccd0c8e0ba54948e4119cd3"
    sha256 cellar: :any, catalina:      "ad84ed490ed2640a32799c5fb3ca7d815c45989f90bf246e087354e60ae23537"
    sha256 cellar: :any, mojave:        "92b00fca6d79e453bf2231d10783912342aa45c7c9ef926998c2ff39e2cc3160"
  end

  depends_on "tcl-tk"

  def install
    args = %W[
      --prefix=#{prefix}
      --datarootdir=#{share}
      --with-tcl=#{Formula["tcl-tk"].opt_lib}
      --without-x
    ]
    system "./configure", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To activate modules, add the following at the end of your .zshrc:
        source #{opt_prefix}/init/zsh
      You will also need to reload your .zshrc:
        source ~/.zshrc
    EOS
  end

  test do
    assert_match "restore", shell_output("#{bin}/envml --help")
    output = shell_output("zsh -c 'source #{prefix}/init/zsh; module' 2>&1")
    assert_match version.to_s, output
  end
end
