class OpenjdkAT8 < Formula
  desc "Development kit for the Java programming language"
  homepage "https://openjdk.java.net/"
  url "https://openjdk-sources.osci.io/openjdk8/openjdk8u302-ga.tar.xz"
  version "1.8.0+302"
  sha256 "ab50669afd85086ba451cbc1560ae76e9bc7fc3c9c46e3d37ee5c6a48bb30124"
  license "GPL-2.0-only"

  bottle do
    sha256 cellar: :any, big_sur:  "13706fb4f8d0f693d14c250a97ec8b70b353018e197412165352c73954892c62"
    sha256 cellar: :any, catalina: "94c61774bdb17d7b8807974aea64c570776eb43dbf269c59767d9c35f4b86318"
    sha256 cellar: :any, mojave:   "97022886f017f84800a97b5da48d8e268c5a3fcba498528fd7d24cd3e72d7a34"
  end

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "pkg-config" => :build
  depends_on "freetype"

  # Oracle doesn't serve JDK 7 downloads anymore, so use Zulu JDK 7 for bootstrapping.
  resource "boot-jdk" do
    on_macos do
      url "https://cdn.azul.com/zulu/bin/zulu7.48.0.11-ca-jdk7.0.312-macosx_x64.tar.gz"
      sha256 "303ccd606307ce37f48ffbaeccaaee72fa3445eb1503c99ae181b372b72701e3"
    end
    on_linux do
      url "https://cdn.azul.com/zulu/bin/zulu7.48.0.11-ca-jdk7.0.312-linux_x64.tar.gz"
      sha256 "c21e30c6a7c0bba75bb9b5ab7933a6ca65db1947e03842278a363f582445c890"
    end
  end

  def install
    _, _, update = version.to_s.rpartition("+")
    java_options = ENV.delete("_JAVA_OPTIONS")

    boot_jdk = buildpath/"boot-jdk"
    resource("boot-jdk").stage(boot_jdk)

    # Work around clashing -I/usr/include and -isystem headers,
    # as superenv already handles this detail for us.
    inreplace "common/autoconf/flags.m4",
              '-isysroot \"$SYSROOT\"', ""
    inreplace "common/autoconf/toolchain.m4",
              '-isysroot \"$SDKPATH\" -iframework\"$SDKPATH/System/Library/Frameworks\"', ""
    inreplace "hotspot/make/bsd/makefiles/saproc.make",
              '-isysroot "$(SDKPATH)" -iframework"$(SDKPATH)/System/Library/Frameworks"', ""

    # Fix macOS version detection. After 10.10 this was changed to a 6 digit number,
    # but this Makefile was written in the era of 4 digit numbers.
    inreplace "hotspot/make/bsd/makefiles/gcc.make" do |s|
      s.gsub! "$(subst .,,$(MACOSX_VERSION_MIN))", ENV["HOMEBREW_MACOS_VERSION_NUMERIC"]
      s.gsub! "MACOSX_VERSION_MIN=10.7.0", "MACOSX_VERSION_MIN=#{MacOS.version}"
    end

    args = %W[--with-boot-jdk-jvmargs=#{java_options}
              --with-boot-jdk=#{boot_jdk}
              --with-debug-level=release
              --with-jvm-variants=server
              --with-milestone=fcs
              --with-native-debug-symbols=none
              --with-toolchain-type=clang
              --with-update-version=#{update}]

    # Work around SDK issues with JavaVM framework.
    if MacOS.version <= :catalina
      sdk_path = MacOS::CLT.sdk_path(MacOS.version)
      ENV["SDKPATH"] = ENV["SDKROOT"] = sdk_path
      javavm_framework_path = sdk_path/"System/Library/Frameworks/JavaVM.framework/Frameworks"
      args += %W[--with-extra-cflags=-F#{javavm_framework_path}
                 --with-extra-cxxflags=-F#{javavm_framework_path}
                 --with-extra-ldflags=-F#{javavm_framework_path}]
    end

    chmod 0755, %w[configure common/autoconf/autogen.sh]

    system "common/autoconf/autogen.sh"
    system "./configure", *args

    ENV["MAKEFLAGS"] = "JOBS=#{ENV.make_jobs}"
    system "make", "images"

    jdk = Dir["build/*/images/j2sdk-bundle/*"].first
    libexec.install jdk => "openjdk.jdk"
    bin.install_symlink Dir["#{libexec}/openjdk.jdk/Contents/Home/bin/*"]
    include.install_symlink Dir["#{libexec}/openjdk.jdk/Contents/Home/include/*.h"]
    include.install_symlink Dir["#{libexec}/openjdk.jdk/Contents/Home/include/darwin/*.h"]
  end

  def caveats
    <<~EOS
      For the system Java wrappers to find this JDK, symlink it with
        sudo ln -sfn #{opt_libexec}/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
    EOS
  end

  test do
    (testpath/"HelloWorld.java").write <<~EOS
      class HelloWorld {
        public static void main(String args[]) {
          System.out.println("Hello, world!");
        }
      }
    EOS

    system bin/"javac", "HelloWorld.java"

    assert_match "Hello, world!", shell_output("#{bin}/java HelloWorld")
  end
end
