class Regipy < Formula
  include Language::Python::Virtualenv

  desc "Offline registry hive parsing tool"
  homepage "https://github.com/mkorman90/regipy"
  url "https://files.pythonhosted.org/packages/72/23/ae827829df2e2feab60c44fd3cf81eee17edc3cec3dea280edc4b777256e/regipy-1.9.4.tar.gz"
  sha256 "86de2da57ccd95fc08ea51fa7e4bef6ed8aa0ab37c4286124bed126bf178c448"
  license "MIT"
  head "https://github.com/mkorman90/regipy.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fac10e536db0d02edf78e62cd142affa66796fa1efdbed6c9440a82fcdce92d6"
    sha256 cellar: :any_skip_relocation, big_sur:       "e227c5846d46a6e394d435a5a595b5cfca14a490d57a55f96fbc4f62745a6239"
    sha256 cellar: :any_skip_relocation, catalina:      "c4cc7ee70d0302df12ea9566b6a584467b04420dd694ea8198dad5fdb25ac550"
    sha256 cellar: :any_skip_relocation, mojave:        "b3530f14c3006c16b91f1da7e488b93e4e07c97665f76aa8fdcd6039450914b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08f6564fa524d8372b6a913aa489ff1f20e9affa7edfeae843a2cf049dd536b0"
  end

  depends_on "python-tabulate"
  depends_on "python@3.9"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/21/83/308a74ca1104fe1e3197d31693a7a2db67c2d4e668f20f43a2fca491f9f7/click-8.0.1.tar.gz"
    sha256 "8c04c11192119b1ef78ea049e0a6f0463e4c48ef00a30160c704337586f3ad7a"
  end

  resource "construct" do
    url "https://files.pythonhosted.org/packages/39/2b/c68eaf8294f01ea534f39b8b4ec1d7308b5195e08570c276b104bccd24ff/construct-2.10.67.tar.gz"
    sha256 "730235fedf4f2fee5cfadda1d14b83ef1bf23790fb1cc579073e10f70a050883"
  end

  resource "inflection" do
    url "https://files.pythonhosted.org/packages/e1/7e/691d061b7329bc8d54edbf0ec22fbfb2afe61facb681f9aaa9bff7a27d04/inflection-0.5.1.tar.gz"
    sha256 "1a29730d366e996aaacffb2f1f1cb9593dc38e2ddd30c91250c6dde09ea9b417"
  end

  resource "jsonlines" do
    url "https://files.pythonhosted.org/packages/bf/40/a1b1810a09e3e85567c17831fcc2fc8e48ad9a1d3b02e8be940c43b908a8/jsonlines-2.0.0.tar.gz"
    sha256 "6fdd03104c9a421a1ba587a121aaac743bf02d8f87fa9cdaa3b852249a241fe8"
  end

  resource "Logbook" do
    url "https://files.pythonhosted.org/packages/2f/d9/16ac346f7c0102835814cc9e5b684aaadea101560bb932a2403bd26b2320/Logbook-1.5.3.tar.gz"
    sha256 "66f454ada0f56eae43066f604a222b09893f98c1adc18df169710761b8f32fe8"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/b0/61/eddc6eb2c682ea6fd97a7e1018a6294be80dba08fa28e7a3570148b4612d/pytz-2021.1.tar.gz"
    sha256 "83a4a90894bf38e243cf052c8b58f381bfe9a7a483f6a9cab140bc7f702ac4da"
  end

  resource "test_hive" do
    url "https://raw.githubusercontent.com/mkorman90/regipy/71acd6a65bdee11ff776dbd44870adad4632404c/regipy_tests/data/SYSTEM.xz"
    sha256 "b1582ab413f089e746da0528c2394f077d6f53dd4e68b877ffb2667bd027b0b0"
  end

  def install
    venv = virtualenv_create(libexec, "python3.9")
    res = resources.map(&:name).to_set
    res -= %w[test_hive]

    res.each do |r|
      venv.pip_install resource(r)
    end

    venv.pip_install_and_link buildpath
  end

  test do
    resource("test_hive").stage do
      system bin/"registry-plugins-run", "-p", "computer_name", "-o", "out.json", "SYSTEM"
      h = JSON.parse(File.read("out.json"))
      assert_equal h["computer_name"][0]["name"], "WKS-WIN732BITA"
      assert_equal h["computer_name"][1]["name"], "WIN-V5T3CSP8U4H"
    end
  end
end
