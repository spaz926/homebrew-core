class ErlangAT22 < Formula
  desc "Programming language for highly scalable real-time systems"
  homepage "https://www.erlang.org/"
  # Download tarball from GitHub; it is served faster than the official tarball.
  url "https://github.com/erlang/otp/releases/download/OTP-22.3.4.20/otp_src_22.3.4.20.tar.gz"
  sha256 "43289f20a7038b6835615a1f68a6e32b9aeec6db38cdb7c97adf78d048d74079"
  license "Apache-2.0"
  revision 1

  livecheck do
    url :stable
    regex(/^OTP[._-]v?(22(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "bf9e22eb6c20285d33d208ef2097efa88bacf01da8447e4cc0a59ef0de70e8ed"
    sha256 cellar: :any, big_sur:       "cfba73ed8488d94e9f8ca6f9b36fd9f0bbd2d2399b382a33202ffcd70743b9c4"
    sha256 cellar: :any, catalina:      "89beffd9e5522bc326988a12ac254a9255f767f47df92a8dd5f952a3a0843d53"
    sha256 cellar: :any, mojave:        "62dbe9073c0354474c8e1a52ca24a84c96cac266066ce0d1b386b40863342e6c"
  end

  keg_only :versioned_formula

  depends_on "openssl@1.1"
  depends_on "wxmac" # for GUI apps like observer

  resource "man" do
    url "https://www.erlang.org/download/otp_doc_man_22.3.tar.gz"
    sha256 "43b6d62d9595e1dc51946d55c9528c706c5ae753876b9bf29303b7d11a7ccb16"
  end

  resource "html" do
    url "https://www.erlang.org/download/otp_doc_html_22.3.tar.gz"
    sha256 "9b01c61f2898235e7f6643c66215d6419f8706c8fdd7c3e0123e68960a388c34"
  end

  def install
    # Unset these so that building wx, kernel, compiler and
    # other modules doesn't fail with an unintelligible error.
    %w[LIBS FLAGS AFLAGS ZFLAGS].each { |k| ENV.delete("ERL_#{k}") }

    args = %W[
      --disable-debug
      --disable-silent-rules
      --prefix=#{prefix}
      --enable-dynamic-ssl-lib
      --enable-hipe
      --enable-shared-zlib
      --enable-smp-support
      --enable-threads
      --enable-wx
      --with-ssl=#{Formula["openssl@1.1"].opt_prefix}
      --without-javac
    ]

    on_macos do
      args << "--enable-darwin-64bit"
      args << "--enable-kernel-poll" if MacOS.version > :el_capitan
      args << "--with-dynamic-trace=dtrace" if MacOS::CLT.installed?
    end

    system "./configure", *args
    system "make"
    system "make", "install"

    (lib/"erlang").install resource("man").files("man")
    doc.install resource("html")
  end

  def caveats
    <<~EOS
      Man pages can be found in:
        #{opt_lib}/erlang/man

      Access them with `erl -man`, or add this directory to MANPATH.
    EOS
  end

  test do
    system "#{bin}/erl", "-noshell", "-eval", "crypto:start().", "-s", "init", "stop"
    (testpath/"factorial").write <<~EOS
      #!#{bin}/escript
      %% -*- erlang -*-
      %%! -smp enable -sname factorial -mnesia debug verbose
      main([String]) ->
          try
              N = list_to_integer(String),
              F = fac(N),
              io:format("factorial ~w = ~w\n", [N,F])
          catch
              _:_ ->
                  usage()
          end;
      main(_) ->
          usage().

      usage() ->
          io:format("usage: factorial integer\n").

      fac(0) -> 1;
      fac(N) -> N * fac(N-1).
    EOS
    chmod 0755, "factorial"
    assert_match "usage: factorial integer", shell_output("./factorial")
    assert_match "factorial 42 = 1405006117752879898543142606244511569936384000000000", shell_output("./factorial 42")
  end
end
