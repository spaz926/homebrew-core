class YouGet < Formula
  include Language::Python::Virtualenv

  desc "Dumb downloader that scrapes the web"
  homepage "https://you-get.org/"
  url "https://files.pythonhosted.org/packages/8e/93/cccb8a10b0845fda8448304e074d6e82cc915d233e504a99fc043c18477c/you-get-0.4.1536.tar.gz"
  sha256 "78c9a113950344e06d18940bd11fe9a2f78b9d0bc8963cde300017ac1ffcef09"
  license "MIT"
  head "https://github.com/soimort/you-get.git", branch: "develop"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "533ca85c6e53acb70051ed35aab5da9d80a2fb5fcbad97b60ceac15e11d3d66a"
    sha256 cellar: :any_skip_relocation, big_sur:       "c30b6cecfc20d8305d977b17b2dab359c5858d84aa4b75085fd5075269ec237b"
    sha256 cellar: :any_skip_relocation, catalina:      "c30b6cecfc20d8305d977b17b2dab359c5858d84aa4b75085fd5075269ec237b"
    sha256 cellar: :any_skip_relocation, mojave:        "c30b6cecfc20d8305d977b17b2dab359c5858d84aa4b75085fd5075269ec237b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "91d946939ea49141bb3e58f1e46cfb75a7db871b15ec03bfb539a4bb66b16501"
  end

  depends_on "python@3.9"
  depends_on "rtmpdump"

  def install
    virtualenv_install_with_resources
  end

  def caveats
    "To use post-processing options, run `brew install ffmpeg` or `brew install libav`."
  end

  test do
    system bin/"you-get", "--info", "https://youtu.be/he2a4xK8ctk"
  end
end
