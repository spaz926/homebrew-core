class StructurizrCli < Formula
  desc "Command-line utility for Structurizr"
  homepage "https://structurizr.com"
  url "https://github.com/structurizr/cli/releases/download/v1.12.0/structurizr-cli-1.12.0.zip"
  sha256 "69c3995531256282e0da7c366e87dd7dc84f4c07ce70760736e4ed0d6001c347"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "19c83b765192bf327a88de77a1b3d711feec832b390751ad45f00008d87af804"
  end

  depends_on "openjdk"

  def install
    libexec.install "structurizr-cli-#{version}.jar"
    bin.write_jar_script libexec/"structurizr-cli-#{version}.jar", "structurizr-cli"
  end

  test do
    expected_output = <<~EOS.strip
      Structurizr CLI v#{version}
      Structurizr DSL v#{version}
      Usage: structurizr push|pull|lock|unlock|export|validate|list [options]
    EOS
    result = pipe_output("#{bin}/structurizr-cli").strip
    assert_equal result, expected_output
  end
end
