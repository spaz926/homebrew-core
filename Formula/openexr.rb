class Openexr < Formula
  desc "High dynamic-range image file format"
  homepage "https://www.openexr.com/"
  # NOTE: Please keep these values in sync with imath.rb when updating.
  url "https://github.com/openexr/openexr/archive/v3.0.5.tar.gz"
  sha256 "7aa6645da70e9a0cce8215d25030cfd4f4b17b4abf1ceec314f7eae15674e8e4"
  license "BSD-3-Clause"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "43a4a1b108ced9e47e56a9b928ef8584451208b6488c3d836ddc825a4af93534"
    sha256 cellar: :any,                 big_sur:       "cd3ab75bcb62e8d614a2f35cc5d869aa39aef8f96da9ba927baa2a948d06cd2e"
    sha256 cellar: :any,                 catalina:      "d2116121c8892b65a58372eca5e879a925e2d1566e6197843c766bf26c81d73e"
    sha256 cellar: :any,                 mojave:        "feb4b0d9f65243c2373140020a24ff362c945075fa11b1c2aeab4c5f5acb6c71"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a6974339b7e4218c21046209dd6e71eff8600349700d0daaac0e6d2fdc9fe96"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "imath"

  uses_from_macos "zlib"

  resource "exr" do
    url "https://github.com/openexr/openexr-images/raw/master/TestImages/AllHalfValues.exr"
    sha256 "eede573a0b59b79f21de15ee9d3b7649d58d8f2a8e7787ea34f192db3b3c84a4"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    resource("exr").stage do
      system bin/"exrheader", "AllHalfValues.exr"
    end
  end
end
