class Httpd < Formula
  desc "Apache HTTP server"
  homepage "https://httpd.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=httpd/httpd-2.4.48.tar.bz2"
  mirror "https://archive.apache.org/dist/httpd/httpd-2.4.48.tar.bz2"
  sha256 "1bc826e7b2e88108c7e4bf43c026636f77a41d849cfb667aa7b5c0b86dbf966c"
  license "Apache-2.0"

  bottle do
    rebuild 1
    sha256 arm64_big_sur: "51a6c522ddeb1cb3a306a31c97d8711fbc8a485cda066adda63b3cf4fa09ef88"
    sha256 big_sur:       "98e4dd6f6f5a5703ceda01113a0e712946bcd299872ea97b54eb55952d5d2fbf"
    sha256 catalina:      "88b47898aa5933e66564b76b53365d52bdcf05aba6738a13c5f6c54973d63c9f"
    sha256 mojave:        "9a498201ae55ce42f3f072572c181b31593e3ed4c8290556939283495a7d9fc7"
    sha256 x86_64_linux:  "08b378464786b56467ef0ea35d46eebd3a7afabe5f65fd3a43917636c6bed8cd"
  end

  depends_on "apr"
  depends_on "apr-util"
  depends_on "brotli"
  depends_on "nghttp2"
  depends_on "openssl@1.1"
  depends_on "pcre"

  uses_from_macos "libxml2"
  uses_from_macos "zlib"

  def install
    # fixup prefix references in favour of opt_prefix references
    inreplace "Makefile.in",
      '#@@ServerRoot@@#$(prefix)#', '#@@ServerRoot@@'"##{opt_prefix}#"
    inreplace "docs/conf/extra/httpd-autoindex.conf.in",
      "@exp_iconsdir@", "#{opt_pkgshare}/icons"
    inreplace "docs/conf/extra/httpd-multilang-errordoc.conf.in",
      "@exp_errordir@", "#{opt_pkgshare}/error"

    # fix default user/group when running as root
    inreplace "docs/conf/httpd.conf.in", /(User|Group) daemon/, "\\1 _www"

    # use Slackware-FHS layout as it's closest to what we want.
    # these values cannot be passed directly to configure, unfortunately.
    inreplace "config.layout" do |s|
      s.gsub! "${datadir}/htdocs", "${datadir}"
      s.gsub! "${htdocsdir}/manual", "#{pkgshare}/manual"
      s.gsub! "${datadir}/error",   "#{pkgshare}/error"
      s.gsub! "${datadir}/icons",   "#{pkgshare}/icons"
    end

    libxml2 = "#{MacOS.sdk_path_if_needed}/usr"
    on_linux { libxml2 = Formula["libxml2"].opt_prefix }
    zlib = "#{MacOS.sdk_path_if_needed}/usr"
    on_linux { zlib = Formula["zlib"].opt_prefix }
    system "./configure", "--enable-layout=Slackware-FHS",
                          "--prefix=#{prefix}",
                          "--sbindir=#{bin}",
                          "--mandir=#{man}",
                          "--sysconfdir=#{etc}/httpd",
                          "--datadir=#{var}/www",
                          "--localstatedir=#{var}",
                          "--enable-mpms-shared=all",
                          "--enable-mods-shared=all",
                          "--enable-authnz-fcgi",
                          "--enable-cgi",
                          "--enable-pie",
                          "--enable-suexec",
                          "--with-suexec-bin=#{opt_bin}/suexec",
                          "--with-suexec-caller=_www",
                          "--with-port=8080",
                          "--with-sslport=8443",
                          "--with-apr=#{Formula["apr"].opt_prefix}",
                          "--with-apr-util=#{Formula["apr-util"].opt_prefix}",
                          "--with-brotli=#{Formula["brotli"].opt_prefix}",
                          "--with-libxml2=#{libxml2}",
                          "--with-mpm=prefork",
                          "--with-nghttp2=#{Formula["nghttp2"].opt_prefix}",
                          "--with-ssl=#{Formula["openssl@1.1"].opt_prefix}",
                          "--with-pcre=#{Formula["pcre"].opt_prefix}",
                          "--with-z=#{zlib}",
                          "--disable-lua",
                          "--disable-luajit"
    system "make"
    on_linux { ENV.deparallelize }
    system "make", "install"

    # suexec does not install without root
    bin.install "support/suexec"

    # remove non-executable files in bin dir (for brew audit)
    rm bin/"envvars"
    rm bin/"envvars-std"

    # avoid using Cellar paths
    inreplace %W[
      #{include}/httpd/ap_config_layout.h
      #{lib}/httpd/build/config_vars.mk
    ] do |s|
      s.gsub! "#{lib}/httpd/modules", "#{HOMEBREW_PREFIX}/lib/httpd/modules"
    end

    inreplace %W[
      #{bin}/apachectl
      #{bin}/apxs
      #{include}/httpd/ap_config_auto.h
      #{include}/httpd/ap_config_layout.h
      #{lib}/httpd/build/config_vars.mk
      #{lib}/httpd/build/config.nice
    ] do |s|
      s.gsub! prefix, opt_prefix
    end

    os = "mac"
    on_linux { os = "linux" }
    inreplace "#{lib}/httpd/build/config_vars.mk" do |s|
      pcre = Formula["pcre"]
      s.gsub! pcre.prefix.realpath, pcre.opt_prefix
      s.gsub! "${prefix}/lib/httpd/modules",
              "#{HOMEBREW_PREFIX}/lib/httpd/modules"
      s.gsub! "#{HOMEBREW_SHIMS_PATH}/#{os}/super",
              "#{HOMEBREW_PREFIX}/bin"
    end
  end

  def post_install
    (var/"cache/httpd").mkpath
    (var/"www").mkpath
  end

  def caveats
    <<~EOS
      DocumentRoot is #{var}/www.

      The default ports have been set in #{etc}/httpd/httpd.conf to 8080 and in
      #{etc}/httpd/extra/httpd-ssl.conf to 8443 so that httpd can run without sudo.
    EOS
  end

  plist_options manual: "apachectl start"

  service do
    run [opt_bin/"httpd", "-D", "FOREGROUND"]
    environment_variables PATH: std_service_path_env
    run_type :immediate
  end

  test do
    # Ensure modules depending on zlib and xml2 have been compiled
    assert_predicate lib/"httpd/modules/mod_deflate.so", :exist?
    assert_predicate lib/"httpd/modules/mod_proxy_html.so", :exist?
    assert_predicate lib/"httpd/modules/mod_xml2enc.so", :exist?

    begin
      port = free_port

      expected_output = "Hello world!"
      (testpath/"index.html").write expected_output
      (testpath/"httpd.conf").write <<~EOS
        Listen #{port}
        ServerName localhost:#{port}
        DocumentRoot "#{testpath}"
        ErrorLog "#{testpath}/httpd-error.log"
        PidFile "#{testpath}/httpd.pid"
        LoadModule authz_core_module #{lib}/httpd/modules/mod_authz_core.so
        LoadModule unixd_module #{lib}/httpd/modules/mod_unixd.so
        LoadModule dir_module #{lib}/httpd/modules/mod_dir.so
        LoadModule mpm_prefork_module #{lib}/httpd/modules/mod_mpm_prefork.so
      EOS

      pid = fork do
        exec bin/"httpd", "-X", "-f", "#{testpath}/httpd.conf"
      end
      sleep 3

      assert_match expected_output, shell_output("curl -s 127.0.0.1:#{port}")
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
