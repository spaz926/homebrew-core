class Semgrep < Formula
  include Language::Python::Virtualenv

  desc "Easily detect and prevent bugs and anti-patterns in your codebase"
  homepage "https://semgrep.dev"
  url "https://github.com/returntocorp/semgrep.git",
      tag:      "v0.59.0",
      revision: "15abd182fc83f5557c8e327956271236fe569d41"
  license "LGPL-2.1-only"
  head "https://github.com/returntocorp/semgrep.git", branch: "develop"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "46cd55a4775c9a415a4841ede024fb46173792744415e19edd086b0fbe7d5057"
    sha256 cellar: :any, big_sur:       "640bd2d7c808b07e7b6cc93a84bdd3f63c86929e445bbb96778a79bce19810c4"
    sha256 cellar: :any, catalina:      "d713a986b978f8506c4b3b50f56017303cb2745466a31943a3a0f88e4c259cd3"
    sha256 cellar: :any, mojave:        "4068942693e4c7215d48dc4cd4fe1870f6427cde74365a803297a59f409259f7"
    sha256               x86_64_linux:  "aff53af8da6fd4e64e3c6e2f26dd4edd7e2b24cdc3d1f71a0944a7337b351976"
  end

  depends_on "cmake" => :build
  depends_on "coreutils"=> :build
  depends_on "dune" => :build
  depends_on "ocaml" => :build
  depends_on "opam" => :build
  depends_on "pkg-config" => :build
  depends_on "pcre"
  depends_on "python@3.9"
  depends_on "tree-sitter"

  uses_from_macos "rsync" => :build

  on_linux do
    depends_on "gcc" => :build
  end

  fails_with gcc: "5"

  # To update, temporarily comment out this resource and run `brew update-python-resources semgrep`
  # Then uncomment this resource and manually modify the commit hash based on
  # https://github.com/returntocorp/semgrep/blob/#{tag}/scripts/install-tree-sitter-runtime
  resource "ocaml-tree-sitter" do
    url "https://github.com/returntocorp/ocaml-tree-sitter-semgrep/archive/2263f3f418f97a849cb9dfeb0373bc9a3a10837c.tar.gz"
    sha256 "f257acdcd1c42c4bbe81ad11ccbadf5211b2b1a062ece3ca04945776f89ada8a"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
  end

  resource "bracex" do
    url "https://files.pythonhosted.org/packages/bb/80/7118945282845f8dc337c45c7d9d171a9f86d0c7650ac7e65d60995691d2/bracex-2.1.1.tar.gz"
    sha256 "01f715cd0ed7a622ec8b32322e715813f7574de531f09b70f6f3b2c10f682425"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/37/fd/05a04d7e14548474d30d90ad0db5d90ee2ba55cd967511a354cf88b534f1/charset-normalizer-2.0.3.tar.gz"
    sha256 "c46c3ace2d744cfbdebceaa3c19ae691f53ae621b39fd7570f59d14fb7f2fd12"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/69/11/a69e2a3c01b324a77d3a7c0570faa372e8448b666300c4117a516f8b1212/jsonschema-3.2.0.tar.gz"
    sha256 "c8a85b28d377cc7737e46e2d9f2b4f44ee3c0e1deac6bf46ddefc7187d30797a"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/86/aef78bab3afd461faecf9955a6501c4999933a48394e90f03cd512aad844/packaging-21.0.tar.gz"
    sha256 "7dc96269f53a4ccec5c0670940a4281106dd0bb343f47b7471f779df49c2fbe7"
  end

  resource "peewee" do
    url "https://files.pythonhosted.org/packages/c9/51/3b2ded25a1cd51d1096bda8e0d1474712fe71efd374ae39b86c73a83d648/peewee-3.14.4.tar.gz"
    sha256 "9e356b327c2eaec6dd42ecea6f4ddded025793dba906a3d065a0452e726c51a2"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz"
    sha256 "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/f4/d7/0fa558c4fb00f15aabc6d42d365fcca7a15fcc1091cd0f5784a14f390b7f/pyrsistent-0.18.0.tar.gz"
    sha256 "773c781216f8c2900b42a7b638d5b517bb134ae1acbebe4d1e8f1f41ea60eb4b"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "ruamel.yaml" do
    url "https://files.pythonhosted.org/packages/83/59/4f576abb336d30b3d47061717224be714a9dc39c774061c34cb41c1795cf/ruamel.yaml-0.17.10.tar.gz"
    sha256 "106bc8d6dc6a0ff7c9196a47570432036f41d556b779c6b4e618085f57e39e67"
  end

  resource "ruamel.yaml.clib" do
    url "https://files.pythonhosted.org/packages/8b/25/08e5ad2431a028d0723ca5540b3af6a32f58f25e83c6dda4d0fcef7288a3/ruamel.yaml.clib-0.2.6.tar.gz"
    sha256 "4ff604ce439abb20794f05613c374759ce10e3595d1867764dd1ae675b85acbd"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/0d/dd/78f7e080d3bfc87fc19bed54513b430659d38efb2d9ea6e3ad815a665a02/tqdm-4.61.2.tar.gz"
    sha256 "8bb94db0d4468fea27d004a0f1d1c02da3cdedc00fe491c0de986b76a04d6b0a"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/4f/5a/597ef5911cb8919efe4d86206aa8b2658616d676a7088f0825ca08bd7cb8/urllib3-1.26.6.tar.gz"
    sha256 "f57b4c16c62fa2760b7e3d97c35b255512fb6b59a259730f36ba32ce9f8e342f"
  end

  resource "wcmatch" do
    url "https://files.pythonhosted.org/packages/47/63/88168196fdcd77e012944bb83ab589a9d53336b8094703a64567f0bf218c/wcmatch-8.2.tar.gz"
    sha256 "4d54ddb506c90b5a5bba3a96a1cfb0bb07127909e19046a71d689ddfb18c3617"
  end

  def install
    (buildpath/"ocaml-tree-sitter").install resource("ocaml-tree-sitter")

    ENV.deparallelize
    Dir.mktmpdir("opamroot") do |opamroot|
      ENV["OPAMROOT"] = opamroot
      ENV["OPAMYES"] = "1"

      # Officially suggested workaround for breaking change in setuptools v50.0.0
      # See: https://sourceforge.net/p/ruamel-yaml/tickets/356/
      # Relevant Issue: https://github.com/pypa/setuptools/issues/2355
      ENV["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"

      system "opam", "init", "--no-setup", "--disable-sandboxing"
      ENV.deparallelize { system "opam", "switch", "create", "ocaml-base-compiler.4.12.0" }

      # Manually run steps from `opam exec -- make setup` to link Homebrew's tree-sitter
      system "opam", "update", "-y"
      ln_s "../../../ocaml-tree-sitter/src", "semgrep-core/src/ocaml-tree-sitter/src"
      ln_s "../ocaml-tree-sitter/tree-sitter.opam", "semgrep-core/tree-sitter.opam"
      system "opam", "install", "-y", "--deps-only", "./semgrep-core/src/pfff"
      system "opam", "install", "-y", "--deps-only", "./semgrep-core"

      # Install tree-sitter
      cd "ocaml-tree-sitter" do
        system "opam", "install", "-y", "."
      end

      # Install semgrep-core and spacegrep
      cd "semgrep-core" do
        system "opam", "install", "--deps-only", "-y", "."
        system "opam", "exec", "--", "make", "all"
        system "opam", "exec", "--", "make", "install"
        bin.install "_build/install/default/bin/semgrep-core" => "semgrep-core"
        bin.install "_build/install/default/bin/spacegrep" => "spacegrep"
      end
    end

    ENV["SEMGREP_SKIP_BIN"] = "1"
    python_path = "semgrep"
    cd python_path do
      venv = virtualenv_create(libexec, Formula["python@3.9"].bin/"python3.9")
      venv.pip_install resources.reject { |r| r.name == "ocaml-tree-sitter" }
      venv.pip_install_and_link buildpath/python_path
    end
  end

  test do
    system "#{bin}/semgrep", "--help"
    (testpath/"script.py").write <<~EOS
      def silly_eq(a, b):
        return a + b == a + b
    EOS

    output = shell_output("#{bin}/semgrep script.py -l python -e '$X == $X'")
    assert_match "a + b == a + b", output
  end
end
