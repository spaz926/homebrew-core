class Scry < Formula
  desc "Code analysis server for Crystal programming language"
  homepage "https://github.com/crystal-lang-tools/scry/"
  url "https://github.com/crystal-lang-tools/scry/archive/v0.9.1.tar.gz"
  sha256 "53bf972557f8b6a697d2aa727df465d6e7d04f6426fcd4559a4d77c90becad81"
  license "MIT"
  head "https://github.com/crystal-lang-tools/scry.git"

  bottle do
    sha256 big_sur:  "8560c26448338c483c2e5aaa488d39156260fa2e891bec02520ae8b8d9e1bcd1"
    sha256 catalina: "da67d98abe3010dc12f6a4152a89dd86a79e1dd098d67afec4a07bfe30c0ccdd"
    sha256 mojave:   "0f243e9970f781e847c7b6906d743e08c1f684c37797ecfd962a1617f7ce8b8f"
  end

  depends_on "bdw-gc"
  depends_on "crystal"
  depends_on "libevent"
  depends_on "pcre"

  uses_from_macos "libiconv"

  def install
    system "shards", "build",
           "--release", "--no-debug", "--verbose",
           "--ignore-crystal-version"
    bin.install "bin/scry"
  end

  test do
    def rpc(json)
      "Content-Length: #{json.size}\r\n" \
        "\r\n" \
        "#{json}"
    end

    input = rpc '{ "jsonrpc": "2.0", "id": 1, "method": "initialize", "params":' \
                '  { "processId": 1, "rootPath": "/dev/null", "capabilities": {}, "trace": "off" } }'
    input += rpc '{ "jsonrpc": "2.0", "method": "initialized", "params": {} }'
    input += rpc '{ "jsonrpc": "2.0", "id":  1, "method": "shutdown" }'
    assert_match(/"capabilities"\s*:\s*{/, pipe_output(bin/"scry", input, 0))
  end
end
