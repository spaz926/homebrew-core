class Bundletool < Formula
  desc "Command-line tool to manipulate Android App Bundles"
  homepage "https://github.com/google/bundletool"
  url "https://github.com/google/bundletool/releases/download/1.7.0/bundletool-all-1.7.0.jar"
  sha256 "2a9202b8e0be1d416b9223b2a81d873097589af5eb009342cecee2cd5b1ba36b"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "646245e8941eb8fd2b76ff1efc35e073368b4f55559d3ecb28beeb5b6d279b4e"
  end

  depends_on "openjdk"

  resource "bundle" do
    url "https://gist.githubusercontent.com/raw/ca85ede7ac072a44f48c658be55ff0d3/sample.aab"
    sha256 "aac71ad62e1f20dd19b80eba5da5cb5e589df40922f288fb6a4b37a62eba27ef"
  end

  def install
    libexec.install "bundletool-all-#{version}.jar" => "bundletool-all.jar"
    (bin/"bundletool").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" -jar "#{libexec}/bundletool-all.jar" "$@"
    EOS
  end

  test do
    resource("bundle").stage do
      expected = <<~EOS
        App Bundle information
        ------------
        Feature modules:
        	Feature module: base
        		File: dex/classes.dex
      EOS

      assert_equal expected, shell_output("#{bin}/bundletool validate --bundle sample.aab")
    end
  end
end
