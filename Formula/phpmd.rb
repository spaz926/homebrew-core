class Phpmd < Formula
  desc "PHP Mess Detector"
  homepage "https://phpmd.org"
  url "https://github.com/phpmd/phpmd/releases/download/2.10.1/phpmd.phar"
  sha256 "c516e4a90c72ccf8170dcc806621c0f0a7ed553b8853aca085e7c38d2e187e61"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "70cff6045cc309d7bbf953341b667208b9e330d9acfc579f5986294e6d9b87ef"
  end

  def install
    bin.install "phpmd.phar" => "phpmd"
  end

  test do
    (testpath/"src/HelloWorld/Greetings.php").write <<~EOS
      <?php
      namespace HelloWorld;
      class Greetings {
        public static function sayHelloWorld($name) {
          return 'HelloHomebrew';
        }
      }
    EOS

    assert_match "Avoid unused parameters such as '$name'.",
      shell_output("#{bin}/phpmd --ignore-violations-on-exit src/HelloWorld/Greetings.php text unusedcode")
  end
end
