class Mariadb < Formula
  desc "Drop-in replacement for MySQL"
  homepage "https://mariadb.org/"
  url "https://downloads.mariadb.com/MariaDB/mariadb-10.6.3/source/mariadb-10.6.3.tar.gz"
  sha256 "5bc125606af5ec1fda80f594c1ddfacef8b305c158ecf8b1ca7a3f01cd0b18db"
  license "GPL-2.0-only"

  livecheck do
    url "https://downloads.mariadb.org/"
    regex(/Download v?(\d+(?:\.\d+)+) Stable Now/i)
  end

  bottle do
    sha256 arm64_big_sur: "41fbb0bbd394de4750e1e9101a94f8a1827d59f0fbf27df76ccc0fd5eeab6da7"
    sha256 big_sur:       "84e53555d27789852d405f63f45e06afc4918c654ae996c3989c05b326cc75db"
    sha256 catalina:      "b9bba3532b154650e8c7e58e55c59a4cdda9918cd6b89840d0efa3f0533f2372"
    sha256 mojave:        "824e0648cffd64e39f994bfd9392678d2c59c39d5f9c7b049b1deefb1cdb8166"
    sha256 x86_64_linux:  "7c9862232af1b8bdb0bd0d25a4afeb90a04616edc8552e5c7b346cb76e645d95"
  end

  depends_on "bison" => :build
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "groonga"
  depends_on "openssl@1.1"
  depends_on "pcre2"

  uses_from_macos "bzip2"
  uses_from_macos "ncurses"
  uses_from_macos "zlib"

  on_macos do
    # Need patch to remove MYSQL_SOURCE_DIR from include path because it contains
    # file called VERSION.
    # https://github.com/Homebrew/homebrew-core/pull/76887#issuecomment-840851149
    # Reported upstream at https://jira.mariadb.org/browse/MDEV-7209 - this fix can be
    # removed once that issue is closed and the fix has been merged into a stable release.
    patch :DATA
  end

  on_linux do
    depends_on "gcc"
    depends_on "linux-pam"
  end

  conflicts_with "mysql", "percona-server",
    because: "mariadb, mysql, and percona install the same binaries"
  conflicts_with "mytop", because: "both install `mytop` binaries"
  conflicts_with "mariadb-connector-c", because: "both install `mariadb_config`"

  fails_with gcc: "5"

  def install
    # Set basedir and ldata so that mysql_install_db can find the server
    # without needing an explicit path to be set. This can still
    # be overridden by calling --basedir= when calling.
    inreplace "scripts/mysql_install_db.sh" do |s|
      s.change_make_var! "basedir", "\"#{prefix}\""
      s.change_make_var! "ldata", "\"#{var}/mysql\""
    end

    # Use brew groonga
    rm_r "storage/mroonga/vendor/groonga"

    # -DINSTALL_* are relative to prefix
    args = %W[
      -DMYSQL_DATADIR=#{var}/mysql
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_MANDIR=share/man
      -DINSTALL_DOCDIR=share/doc/#{name}
      -DINSTALL_INFODIR=share/info
      -DINSTALL_MYSQLSHAREDIR=share/mysql
      -DWITH_READLINE=yes
      -DWITH_SSL=yes
      -DWITH_UNIT_TESTS=OFF
      -DDEFAULT_CHARSET=utf8mb4
      -DDEFAULT_COLLATION=utf8mb4_general_ci
      -DINSTALL_SYSCONFDIR=#{etc}
      -DCOMPILATION_COMMENT=#{tap.user}
    ]

    # Disable RocksDB on Apple Silicon (currently not supported)
    args << "-DPLUGIN_ROCKSDB=NO" if Hardware::CPU.arm?

    system "cmake", ".", *std_cmake_args, *args

    on_macos do
      # Need to rename files called version/VERSION to avoid build failure
      # https://github.com/Homebrew/homebrew-core/pull/76887#issuecomment-840851149
      # Reported upstream at https://jira.mariadb.org/browse/MDEV-7209 - this fix can be
      # removed once that issue is closed and the fix has been merged into a stable release.
      mv "storage/mroonga/version", "storage/mroonga/version.txt"
    end

    system "make"
    system "make", "install"

    # Fix my.cnf to point to #{etc} instead of /etc
    (etc/"my.cnf.d").mkpath
    inreplace "#{etc}/my.cnf", "!includedir /etc/my.cnf.d",
                               "!includedir #{etc}/my.cnf.d"
    touch etc/"my.cnf.d/.homebrew_dont_prune_me"

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix/"data"

    # Save space
    (prefix/"mysql-test").rmtree
    (prefix/"sql-bench").rmtree

    # Link the setup script into bin
    bin.install_symlink prefix/"scripts/mysql_install_db"

    # Fix up the control script and link into bin
    inreplace "#{prefix}/support-files/mysql.server", /^(PATH=".*)(")/, "\\1:#{HOMEBREW_PREFIX}/bin\\2"

    bin.install_symlink prefix/"support-files/mysql.server"

    # Move sourced non-executable out of bin into libexec
    libexec.install "#{bin}/wsrep_sst_common"
    # Fix up references to wsrep_sst_common
    %w[
      wsrep_sst_mysqldump
      wsrep_sst_rsync
      wsrep_sst_mariabackup
    ].each do |f|
      inreplace "#{bin}/#{f}", "$(dirname \"$0\")/wsrep_sst_common",
                               "#{libexec}/wsrep_sst_common"
    end

    # Install my.cnf that binds to 127.0.0.1 by default
    (buildpath/"my.cnf").write <<~EOS
      # Default Homebrew MySQL server config
      [mysqld]
      # Only allow connections from localhost
      bind-address = 127.0.0.1
    EOS
    etc.install "my.cnf"
  end

  def post_install
    # Make sure the var/mysql directory exists
    (var/"mysql").mkpath

    # Don't initialize database, it clashes when testing other MySQL-like implementations.
    return if ENV["HOMEBREW_GITHUB_ACTIONS"]

    unless File.exist? "#{var}/mysql/mysql/user.frm"
      ENV["TMPDIR"] = nil
      system "#{bin}/mysql_install_db", "--verbose", "--user=#{ENV["USER"]}",
        "--basedir=#{prefix}", "--datadir=#{var}/mysql", "--tmpdir=/tmp"
    end
  end

  def caveats
    <<~EOS
      A "/etc/my.cnf" from another install may interfere with a Homebrew-built
      server starting up correctly.

      MySQL is configured to only allow connections from localhost by default
    EOS
  end

  plist_options manual: "mysql.server start"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/mysqld_safe</string>
          <string>--datadir=#{var}/mysql</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
      </dict>
      </plist>
    EOS
  end

  test do
    (testpath/"mysql").mkpath
    (testpath/"tmp").mkpath
    system bin/"mysql_install_db", "--no-defaults", "--user=#{ENV["USER"]}",
      "--basedir=#{prefix}", "--datadir=#{testpath}/mysql", "--tmpdir=#{testpath}/tmp",
      "--auth-root-authentication-method=normal"
    port = free_port
    fork do
      system "#{bin}/mysqld", "--no-defaults", "--user=#{ENV["USER"]}",
        "--datadir=#{testpath}/mysql", "--port=#{port}", "--tmpdir=#{testpath}/tmp"
    end
    sleep 5
    assert_match "information_schema",
      shell_output("#{bin}/mysql --port=#{port} --user=root --password= --execute='show databases;'")
    system "#{bin}/mysqladmin", "--port=#{port}", "--user=root", "--password=", "shutdown"
  end
end

__END__
diff --git a/storage/mroonga/CMakeLists.txt b/storage/mroonga/CMakeLists.txt
index 555ab248751..cddb6f2f2a6 100644
--- a/storage/mroonga/CMakeLists.txt
+++ b/storage/mroonga/CMakeLists.txt
@@ -215,8 +215,7 @@ set(MYSQL_INCLUDE_DIRS
   "${MYSQL_REGEX_INCLUDE_DIR}"
   "${MYSQL_RAPIDJSON_INCLUDE_DIR}"
   "${MYSQL_LIBBINLOGEVENTS_EXPORT_DIR}"
-  "${MYSQL_LIBBINLOGEVENTS_INCLUDE_DIR}"
-  "${MYSQL_SOURCE_DIR}")
+  "${MYSQL_LIBBINLOGEVENTS_INCLUDE_DIR}")

 if(MRN_BUNDLED)
   set(MYSQL_PLUGIN_DIR "${INSTALL_PLUGINDIR}")
