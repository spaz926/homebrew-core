class Proguard < Formula
  desc "Java class file shrinker, optimizer, and obfuscator"
  homepage "https://www.guardsquare.com/en/products/proguard"
  url "https://github.com/Guardsquare/proguard/releases/download/v7.1.0/proguard-7.1.0.tar.gz"
  sha256 "a6177c2f64c0433a011ebe0acaf21c2c9becbda9d7a373e0d7afca68110a0a33"
  license "GPL-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, all: "57711dd09b9fd6e9642688e782d49fcebbad9c6b9718635171e659a48867dded"
  end

  depends_on "openjdk"

  def install
    libexec.install "lib/proguard.jar"
    libexec.install "lib/proguardgui.jar"
    libexec.install "lib/retrace.jar"
    bin.write_jar_script libexec/"proguard.jar", "proguard"
    bin.write_jar_script libexec/"proguardgui.jar", "proguardgui"
    bin.write_jar_script libexec/"retrace.jar", "retrace"
  end

  test do
    expect = <<~EOS
      ProGuard, version #{version}
      Usage: java proguard.ProGuard [options ...]
    EOS
    assert_equal expect, shell_output("#{bin}/proguard", 1)

    expect = <<~EOS
      Picked up _JAVA_OPTIONS: #{ENV["_JAVA_OPTIONS"]}
      Usage: java proguard.retrace.ReTrace [-regex <regex>] [-allclassnames] [-verbose] <mapping_file> [<stacktrace_file>]
    EOS
    assert_match expect, pipe_output("#{bin}/retrace 2>&1")
  end
end
