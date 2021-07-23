class Activemq < Formula
  desc "Apache ActiveMQ: powerful open source messaging server"
  homepage "https://activemq.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=activemq/5.16.2/apache-activemq-5.16.2-bin.tar.gz"
  mirror "https://archive.apache.org/dist/activemq/5.16.2/apache-activemq-5.16.2-bin.tar.gz"
  sha256 "212feca1ee4bc750befd45a735cbfef00c0c9aee451ef5116e991330c1ab105b"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "e9b4d36bb04448419691a35a64a784249748ab2ae57cf73963834a99d31a06da"
  end

  depends_on "openjdk"

  def install
    on_macos do
      rm_rf Dir["bin/linux-x86-*"]
    end
    libexec.install Dir["*"]
    (bin/"activemq").write_env_script libexec/"bin/activemq", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  service do
    run [opt_bin/"activemq", "start"]
    working_dir opt_libexec
  end

  test do
    system "#{bin}/activemq", "browse", "-h"
  end
end
