class SpatialiteGui < Formula
  desc "GUI tool supporting SpatiaLite"
  homepage "https://www.gaia-gis.it/fossil/spatialite_gui/index"
  url "https://www.gaia-gis.it/gaia-sins/spatialite-gui-sources/spatialite_gui-1.7.1.tar.gz"
  sha256 "cb9cb1ede7f83a5fc5f52c83437e556ab9cb54d6ace3c545d31b317fd36f05e4"
  license "GPL-3.0-or-later"
  revision 8

  livecheck do
    url "https://www.gaia-gis.it/gaia-sins/spatialite-gui-sources/"
    regex(/href=.*?spatialite[._-]gui[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "e1c8f91baf7afb92406e70a732d5af5c16f8671f3e8fb51aa5e8113b61790f9f"
    sha256 cellar: :any, big_sur:       "6ab3c3a9ca5849231279f2651685f45ec0543d545f033f16906fe5af65fecbe4"
    sha256 cellar: :any, catalina:      "7894a76f911b9bc9b0a0322983601a42845915a99945f642820d8a07e13a8a16"
    sha256 cellar: :any, mojave:        "2123985cc139f7b5962879c9731094be26053bd3596bb689f2138a800d295f20"
  end

  depends_on "pkg-config" => :build
  depends_on "freexl"
  depends_on "geos"
  depends_on "libgaiagraphics"
  depends_on "libspatialite"
  depends_on "proj@7"
  depends_on "sqlite"
  depends_on "wxmac@3.0"

  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/spatialite-gui/1.7.1.patch"
    sha256 "37f71f3cb2b0b9649eb85a51296187b0adf2972c5a1d3ee0daf3082e2c35025e"
  end

  def install
    wxmac = Formula["wxmac@3.0"]
    ENV["WX_CONFIG"] = wxmac.opt_bin/"wx-config-#{wxmac.version.major_minor}"

    # Link flags for sqlite don't seem to get passed to make, which
    # causes builds to fatally error out on linking.
    # https://github.com/Homebrew/homebrew/issues/44003
    #
    # spatialite-gui uses `proj` (instead of `proj@7`) if installed
    sqlite = Formula["sqlite"]
    proj = Formula["proj@7"]
    ENV.prepend "LDFLAGS", "-L#{sqlite.opt_lib} -lsqlite3 -L#{proj.opt_lib}"
    ENV.prepend "CFLAGS", "-I#{sqlite.opt_include} -I#{proj.opt_include}"

    # Use Proj 6.0.0 compatibility headers
    # https://www.gaia-gis.it/fossil/spatialite_gui/tktview?name=8349866db6
    ENV.append_to_cflags "-DACCEPT_USE_OF_DEPRECATED_PROJ_API_H"

    # Add aui library; reported upstream multiple times:
    # https://groups.google.com/forum/#!searchin/spatialite-users/aui/spatialite-users/wnkjK9pde2E/hVCpcndUP_wJ
    inreplace "configure" do |s|
      s.gsub! "WX_LIBS=\"$(wx-config --libs)\"", "WX_LIBS=\"$(wx-config --libs std,aui)\""
      # configure does not make proper use of `WX_CONFIG`
      s.gsub! "S=\"$(wx-config --", "S=\"$($WX_CONFIG --"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
