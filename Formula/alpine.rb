class Alpine < Formula
  desc "News and email agent"
  homepage "https://alpine.x10host.com/alpine/release/"
  url "https://alpine.x10host.com/alpine/release/src/alpine-2.24.tar.xz"
  sha256 "651a9ffa0a29e2b646a0a6e0d5a2c8c50f27a07a26a61640b7c783d06d0abcef"
  license "Apache-2.0"
  head "https://repo.or.cz/alpine.git"

  livecheck do
    url :homepage
    regex(/href=.*?alpine[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "273db81b08b89a37f782da98e32134526682146c05221bfa230bfbf63220f899"
    sha256 big_sur:       "bc7e92be45c91c784791a4be2cc2569bed0b686d132f4cdfd0d0233be091643d"
    sha256 catalina:      "8a856082da848d13cc4019f3bed974e896144b0cf192125285e20a7250a72295"
    sha256 mojave:        "43533b14f530c72a3f89dbaebf2c4efcd66c8c7fc89349e56d714ff15f2af02e"
    sha256 high_sierra:   "bed10deca1df682e23ffec4b21af9f837db1dbf011879ab0df579efc81116db1"
    sha256 x86_64_linux:  "6d153e2a1bf60fda3eae6de5fb9b5a67e3168df9fb4eb1b253f1e6fc01765ab3"
  end

  depends_on "openssl@1.1"

  uses_from_macos "ncurses"
  uses_from_macos "openldap"

  on_linux do
    depends_on "linux-pam"
  end

  def install
    ENV.deparallelize

    args = %W[
      --disable-debug
      --with-ssl-dir=#{Formula["openssl@1.1"].opt_prefix}
      --with-ssl-certs-dir=#{etc}/openssl@1.1
      --prefix=#{prefix}
      --with-bundled-tools
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/alpine", "-conf"
  end
end
