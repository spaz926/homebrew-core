class Phpbrew < Formula
  desc "Brew & manage PHP versions in pure PHP at HOME"
  homepage "https://phpbrew.github.io/phpbrew"
  url "https://github.com/phpbrew/phpbrew/releases/download/1.27.0/phpbrew.phar"
  sha256 "0fdcda638851ef7e306f5046ff1f9de291443656a35f5150d84368c88aa7a41a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "99b8cb5b36039f9ea05b31f33f040ac83833835b75e1bf3148c36940d805324c"
    sha256 cellar: :any_skip_relocation, big_sur:       "2665bd49848a852a87abfc444f8ef708e3ec8364b3e5c04f21c3d7ef7ed8bdde"
    sha256 cellar: :any_skip_relocation, catalina:      "2665bd49848a852a87abfc444f8ef708e3ec8364b3e5c04f21c3d7ef7ed8bdde"
    sha256 cellar: :any_skip_relocation, mojave:        "2665bd49848a852a87abfc444f8ef708e3ec8364b3e5c04f21c3d7ef7ed8bdde"
  end

  # Keg-relocation breaks the formula when it replaces `/usr/local` with a non-default prefix
  pour_bottle? do
    on_macos do
      reason "The bottle needs to be installed into `#{Homebrew::DEFAULT_PREFIX}` on Intel macOS."
      satisfy { HOMEBREW_PREFIX.to_s == Homebrew::DEFAULT_PREFIX || Hardware::CPU.arm? }
    end
  end

  uses_from_macos "php"

  def install
    chmod "+x", "phpbrew.phar"
    bin.install "phpbrew.phar" => "phpbrew"
  end

  test do
    system bin/"phpbrew", "init"
    assert_match "8.0", shell_output("#{bin}/phpbrew known")
  end
end
