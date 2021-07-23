require "language/node"

class WebtorrentCli < Formula
  desc "Command-line streaming torrent client"
  homepage "https://webtorrent.io/"
  url "https://registry.npmjs.org/webtorrent-cli/-/webtorrent-cli-3.5.3.tgz"
  sha256 "96d2d1c412aa35ca782d89f01c3b8780f5fee0b1ec6f8ea1a08b4f32aef6d93a"
  license "MIT"

  bottle do
    sha256                               arm64_big_sur: "2c9adec9ee2f72ae0426fea5e2ac5451840bf8bc104b6bf378e9ba575d39b3ca"
    sha256                               big_sur:       "d627da27af5ce0bb583e1dd3dc18a4ab4923e49724958de48f1d7e3371ad0c9f"
    sha256                               catalina:      "8978b6cdb4e7d97b87995bdb1d9859a3216e416684acd21cbb63d067d64ddbb5"
    sha256                               mojave:        "348e39c536cd646ae65cb91046fc0ab9adbd680ac4efad3d5e9f0585ef5489c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea4375590f79953a29f9f599d641f68d0fc41554355f05c5f4fc32cf4e4e6fea"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    magnet_uri = <<~EOS.gsub(/\s+/, "").strip
      magnet:?xt=urn:btih:9eae210fe47a073f991c83561e75d439887be3f3
      &dn=archlinux-2017.02.01-x86_64.iso
      &tr=udp://tracker.archlinux.org:6969
      &tr=https://tracker.archlinux.org:443/announce
    EOS

    expected_output_raw = <<~EOS
      {
        "xt": "urn:btih:9eae210fe47a073f991c83561e75d439887be3f3",
        "dn": "archlinux-2017.02.01-x86_64.iso",
        "tr": [
          "https://tracker.archlinux.org:443/announce",
          "udp://tracker.archlinux.org:6969"
        ],
        "infoHash": "9eae210fe47a073f991c83561e75d439887be3f3",
        "name": "archlinux-2017.02.01-x86_64.iso",
        "announce": [
          "https://tracker.archlinux.org:443/announce",
          "udp://tracker.archlinux.org:6969"
        ],
        "urlList": []
      }
    EOS
    expected_json = JSON.parse(expected_output_raw)
    actual_output_raw = shell_output("#{bin}/webtorrent info '#{magnet_uri}'")
    actual_json = JSON.parse(actual_output_raw)
    assert_equal expected_json["tr"].to_set, actual_json["tr"].to_set
    assert_equal expected_json["announce"].to_set, actual_json["announce"].to_set
  end
end
